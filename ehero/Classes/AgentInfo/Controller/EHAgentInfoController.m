//
//  EHAgentInfoController.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoController.h"
#import "EHAgentInfo.h"
#import "ShareView.h"
#import "EHCallAgentView.h"
#import "STModal.h"
#import "EHVerifyView.h"
#import "EHCookieOperation.h"
#import "EHSocialShareViewModel.h"
#import "EHAgentInfoTableViewModel.h"
#import "EHAgentInfoNetViewModel.h"
#import "EHSkimedAgentViewModel.h"
#import "MJExtension.h"
#import "EHCommentInfo.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
#import "EHCommentAgentViewController.h"


@interface EHAgentInfoController ()<EHVerifyViewDelegate>
{
    EHCallAgentView *callAgentView;
    EHVerifyView *verifyView;
    CTCallCenter *callCenter;
}
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
- (IBAction)commentBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (nonatomic,strong) STModal *modal;
@property (nonatomic,strong) EHSocialShareViewModel *socialViewModel;
@property (nonatomic,strong) EHAgentInfoTableViewModel *agentInfoTableViewModel;
@property (nonatomic,strong) EHAgentInfoNetViewModel *agentInfoNetViewModel;
@property (nonatomic,strong) EHSkimedAgentViewModel *skimedAgentViewModel;

@end

@implementation EHAgentInfoController{
    BOOL selectedFlag;
    NSMutableArray *titleArray;
    NSMutableArray *picArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.agentInfo.name;
    self.view.backgroundColor = RGB(241, 243, 245);

    titleArray = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈",@"微博",@"QQ好友", nil];
    picArray = [NSMutableArray arrayWithObjects:@"share_wechat",@"share_timeline",@"share_weibo",@"share_qq",nil];
    
    //初始化弹窗配置
    _modal = [STModal modal];
    _modal.hideWhenTouchOutside = YES;
    
    //设置顶部分割线
    [self.navigationController.navigationBar
     addSubview:[EHTipsNavBottomLine initNavBottomLineWithController:self]];

   
    [self callCallBack];
    [self initViewModels];
    
    [self transData];
    
    //数据传递
    [_agentInfoNetViewModel getAverageInfo:^(EHAverageInfo *averageInfo){
        _agentInfoTableViewModel.averageInfo = averageInfo;
        
    }];
    
    [RACObserve(self.agentInfoTableViewModel, commentKind)subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self reloadAgentInfo];
    [self isCollected];
    [self.tableView reloadData];
}

- (void)initViewModels{
    _socialViewModel = [[EHSocialShareViewModel alloc]init];
    _agentInfoTableViewModel = [[EHAgentInfoTableViewModel alloc]init];
    _agentInfoTableViewModel.agentInfo = self.agentInfo;
    _agentInfoTableViewModel.superVC = self;
    _agentInfoTableViewModel.commentsArray = [NSMutableArray array];
    _agentInfoTableViewModel.niceCommentsArray = [NSMutableArray array];
    _agentInfoTableViewModel.commonCommentsArray = [NSMutableArray array];
    _agentInfoTableViewModel.badCommentsArray = [NSMutableArray array];
    _agentInfoTableViewModel.commentKind = 1;
    
    self.tableView.dataSource = _agentInfoTableViewModel;
    self.tableView.delegate = _agentInfoTableViewModel;
    
    _agentInfoNetViewModel = [[EHAgentInfoNetViewModel alloc]init];
    _agentInfoNetViewModel.superVC = self;
    
    
    _skimedAgentViewModel = [[EHSkimedAgentViewModel alloc]init];
    [_skimedAgentViewModel skimedAndSaveWithAgentInfo:self.agentInfo];
}

# pragma mark - searchResultCellDelegate
- (void)callBtnClick:(UITableViewCell *)cell{
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
}

- (void)callActionWithCode:(NSString *)code{
    [self showCallAgentView];
    [MBProgressHUD showMessage:@"正在接通电话中..."];
    [_agentInfoNetViewModel callAgentWithIdStr:self.agentInfo.idStr code:code success:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
            [_modal hide:YES];
        });
    } failure:^{
        [_modal hide:YES];
        [MBProgressHUD hideHUDForView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"拨打失败"];
        });
    }];
}

- (void)popVerifyView{
    verifyView = [EHVerifyView initVerifyView];
    verifyView.delegate = self;
    [verifyView setupCountdownBtn];
    [_modal showContentView:verifyView animated:YES];
}

# pragma mark - EHVerifyViewDelegate
- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [_modal hide:YES];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
   
           [self showCallAgentView];
        [MBProgressHUD showMessage:@"正在接通电话中..."];
        [_agentInfoNetViewModel callAgentWithIdStr:self.agentInfo.idStr code:code success:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];
                [_modal hide:YES];
            });
        } failure:^{
            [_modal hide:YES];
            [MBProgressHUD hideHUDForView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"拨打失败"];
            });
        }];
    });
    
}

- (void)showCallAgentView{
    callAgentView = [EHCallAgentView initCallAgentView];
    NSMutableString *mobileString = [NSMutableString stringWithString:self.agentInfo.mobile];
    [mobileString insertString:@"-" atIndex:3];
    [mobileString insertString:@"-" atIndex:8];
    
    [callAgentView setCallAgentViewWithName:self.agentInfo.name
                                     mobile:mobileString
                                      txUrl:self.agentInfo.tx];
    [_modal showContentView:callAgentView animated:YES];
}

# pragma mark - 分享点击
- (IBAction)shareBtnClick:(id)sender {
    //分享界面弹窗
    ShareView *share = [[ShareView alloc]initWithTitleArray:titleArray picArray:picArray];
    [share showShareView];
    [share currentIndexWasSelected:^(NSInteger index) {
        _socialViewModel.desc = @"大数据推荐最匹配的经纪人";
        _socialViewModel.title = [NSString stringWithFormat:@"为您分享经纪人:%@",self.agentInfo.name];
        _socialViewModel.link = [NSString stringWithFormat:@"http://ehero.cc/agents/%@",self.agentInfo.idStr];
        [_socialViewModel shareWithIndex:index];
    }];
}

# pragma mark - 收藏点击
- (IBAction)collectBtnClick:(id)sender {
    selectedFlag = !selectedFlag;
     _agentInfoTableViewModel.commentKind =1;
    [self.tableView reloadData];
   
    if (selectedFlag) {
        self.collectBtn.selected = YES;
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        [self collect];

    }else{
        self.collectBtn.selected = NO;
        NSString *sqlForName = [NSString stringWithFormat:@" WHERE name = '%@' ",self.agentInfo.name];
        EHAgentInfo *agentInfo = [EHAgentInfo findFirstByCriteria:sqlForName];
        [agentInfo deleteObject];
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.view];
    }
}

- (void)collect{
    [self.agentInfo save];
}

- (void)cancelCollect{
    [self.agentInfo deleteObject];

}
#pragma mark - 判断是否收藏已经收藏
- (void)isCollected{
    //EHAgentInfo *agentInfo
    NSString *sqlForName = [NSString stringWithFormat:@" WHERE name = '%@' ",self.agentInfo.name];
    EHAgentInfo *collectedAgentExisted = [EHAgentInfo findFirstByCriteria:sqlForName];
    
    if (collectedAgentExisted == nil) {
        selectedFlag = NO;
        self.collectBtn.selected = NO;
    }else{
        selectedFlag = YES;
        self.collectBtn.selected = YES;
    }
    
}

#pragma mark - 监听电话回调
- (void)callCallBack
{
    callCenter = [[CTCallCenter alloc] init];
    __weak STModal *weakmodal = self.modal;
    __weak EHAgentInfoController *weakself = self;
    callCenter.callEventHandler = ^(CTCall* call) {
        if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
            [MBProgressHUD hideHUDForView:weakself.view];
            [weakmodal hide:YES];
        }
    };
}
#pragma mark - 传递数据(评论)
- (void)transData{
    [_agentInfoTableViewModel.commentsArray removeAllObjects];
    [_agentInfoTableViewModel.niceCommentsArray removeAllObjects];
    [_agentInfoTableViewModel.commonCommentsArray removeAllObjects];
    [_agentInfoTableViewModel.badCommentsArray removeAllObjects];
    _agentInfoTableViewModel.commentsArray = [EHCommentInfo mj_objectArrayWithKeyValuesArray:_agentInfo.comments];
    
    for (EHCommentInfo *comment in _agentInfoTableViewModel.commentsArray) {
        if ([comment.kind isEqualToString:@"nice"]) {
            [_agentInfoTableViewModel.niceCommentsArray addObject:comment];
        }else if([comment.kind isEqualToString:@"bad"]){
            [_agentInfoTableViewModel.badCommentsArray addObject:comment];
  
        }else{
            [_agentInfoTableViewModel.commonCommentsArray addObject:comment];
        }
    }
}

- (IBAction)commentBtnClick:(id)sender {
    EHCommentAgentViewController *commentAgentVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"CommentAgentViewController"];
    commentAgentVC.agentInfo = self.agentInfo;
    [self.navigationController pushViewController:commentAgentVC animated:YES];
    
}

- (void)reloadAgentInfo{
    
    [_agentInfoNetViewModel getAgentInfo:self.agentInfo.name success:^(NSArray *resultArray) {
        for(EHAgentInfo *info in resultArray){
            [info getIdStringFromDictionary];
            if([info.idStr isEqualToString:_agentInfo.idStr]){
                self.agentInfo = info;
                break;
            }
        }
        [self transData];
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

@end
