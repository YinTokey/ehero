//
//  EHHouseDetailViewController.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseDetailViewController.h"
#import "EHHouseSourcesCell.h"
#import "EHHouseDetailCell.h"
#import "EHHouseDetailAgentCell.h"
#import "EHHouseDetailCallCell.h"
#import "EHRegularExpression.h"
#import "EHCookieOperation.h"
#import "STModal.h"
#import "EHVerifyView.h"
#import "EHAgentInfoNetViewModel.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
@interface EHHouseDetailViewController ()<detailCallCellDelegate,EHVerifyViewDelegate>

@property (nonatomic,strong) EHAgentInfoNetViewModel *agentInfoNetViewModel;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation EHHouseDetailViewController
{
    STModal *modal;
    EHVerifyView *verifyView;
    CTCallCenter *callCenter;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //初始化弹窗配置
    modal = [STModal modal];
    modal.hideWhenTouchOutside = YES;
    [self callCallBack];
    
    [YTHttpTool netCheck];
    
    _agentInfoNetViewModel = [[EHAgentInfoNetViewModel alloc]init];
    _agentInfoNetViewModel.superVC = self;
    
    NSLog(@"%@",_agentInfo.company);
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return ScreenHeight * 0.644;
    }else if(indexPath.row == 1){
        EHHousesInfo *houseInfo = _houseInfo;
        return houseInfo.cellHeight;
    }else{
        return 36;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==  0) {
        EHHouseDetailCell *cell = [EHHouseDetailCell houseDetailCellWithTableView:tableView];
        cell.houseInfo = _houseInfo;
        return cell;
    }else if (indexPath.row == 1){
        EHHouseDetailAgentCell *cell = [EHHouseDetailAgentCell houseDetailAgentCellWithTableView:tableView];
        cell.houseInfo = _houseInfo;
        cell.agetnInfo = _agentInfo;
        return cell;
    }else{
        EHHouseDetailCallCell *cell = [EHHouseDetailCallCell houseDetailCallCellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }
}

- (void)callClick:(UITableViewCell *)cell{

    if (self.agentInfo.mobile.length > 5) {
        //如果有cookie
        if ([EHCookieOperation setCookie]) {
            NSLog(@"有cookie,设置成功，不用再验证");
            NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
            NSDictionary *codeDic = [defualts objectForKey:@"codeDic"];
            //在评论界面完成验证
            if (codeDic) {
                NSDate *dateNow = [NSDate date];
                NSDate *codeDate = [codeDic objectForKey:@"date"];
                NSTimeInterval interval = [dateNow timeIntervalSinceDate:codeDate];
                NSInteger resultInterval = ((NSInteger)interval);
                if(resultInterval <= 24*3600 ){  //24小时内，直接用
                    [self callActionWithCode:[codeDic objectForKey:@"code"]];
                }else{
                    //验证界面
                    [self popVerifyView];
                }
            }else{
                [self callActionWithCode:@" "];
            }
        }else{
            //验证界面
            [self popVerifyView];
        }
    }else{
        [MBProgressHUD showError:@"没有该经纪人电话" toView:self.view];
    }
}


- (void)callActionWithCode:(NSString *)code{

    [MBProgressHUD showMessage:@"正在接通电话中..." toView:self.view];
    [_agentInfoNetViewModel callAgentWithIdStr:self.agentInfo.idStr code:code success:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            
        });
    } failure:^{
        [MBProgressHUD hideHUDForView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"拨打失败"];
        });
        
    }];
}


- (void)callCallBack
{
    callCenter = [[CTCallCenter alloc] init];
    __weak EHHouseDetailViewController *weakself = self;
    callCenter.callEventHandler = ^(CTCall* call) {
        if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
            [MBProgressHUD hideHUDForView:weakself.view];
        }
    };
}

- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:@"正在接通电话中..."];
        [_agentInfoNetViewModel callAgentWithIdStr:self.agentInfo.idStr code:code success:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [modal hide:YES];
            });
        } failure:^{
            [modal hide:YES];
            [MBProgressHUD hideHUDForView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"拨打失败"];
            });
        }];
    });

}


- (void)popVerifyView{
    //验证界面
    verifyView = [EHVerifyView initVerifyView];
    verifyView.delegate = self;
    [verifyView setupCountdownBtn];
    [modal showContentView:verifyView animated:YES];
}

@end
