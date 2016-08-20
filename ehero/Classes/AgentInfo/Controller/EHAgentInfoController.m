//
//  EHAgentInfoController.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoController.h"
#import "EHAgentInfoCommunityCell.h"
#import "EHSearchResultCell.h"
#import "EHAgentInfo.h"
#import "EHAgentInfoCommentCell.h"
#import "ShareView.h"
#import <OpenShareHeader.h>
#import "EHCallAgentView.h"
#import "STModal.h"
#import "EHVerifyView.h"
#import "EHSkimedAgentInfo.h"
#import "YTHttpTool.h"
#import "EHCookieOperation.h"

#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
@interface EHAgentInfoController ()<EHSearchResultCellDelegate,EHVerifyViewDelegate>
{
    EHCallAgentView *callAgentView;
    STModal *modal;
    EHVerifyView *verifyView;
    CTCallCenter *callCenter;
}
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end

@implementation EHAgentInfoController{
    UIImage *thumbImage;
    BOOL selectedFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.agentInfo.name;
    self.view.backgroundColor = RGB(241, 243, 245);
    //初始化分享图标
    thumbImage = [UIImage imageNamed:@"share_icon"];
    //初始化弹窗配置
    modal = [STModal modal];
    modal.hideWhenTouchOutside = YES;
    
    //设置顶部分割线
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];

    [self skimedAndSave];

    [self isCollected];
}


#pragma mark - Table view data source

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1){
        return 115;
    }else{
        return 125;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0 || section == 1) {
        return 1;
    }else
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
        [cell setResultCell:self.agentInfo];
        cell.isdrawRect = NO;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }else if(indexPath.section == 1){
        EHAgentInfoCommunityCell *cell = [EHAgentInfoCommunityCell AgentInfoCommunityCellWithTableView:tableView];
        return cell;
    }else{
        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];

        return cell;
    
    }
}


# pragma mark - searchResultCellDelegate
- (void)callBtnClick:(UITableViewCell *)cell{
    NSLog(@"点击经纪人详情界面的打电话");
    //如果有cookie
    
    if ([EHCookieOperation setCookie]) {
        NSLog(@"有cookie,设置成功，不用再验证");
        //呼叫经纪人界面
        callAgentView = [EHCallAgentView initCallAgentView];
        //修改电话号码格式
        NSMutableString *mobileString = [NSMutableString stringWithString:self.agentInfo.mobile];
        [mobileString insertString:@"-" atIndex:3];
        [mobileString insertString:@"-" atIndex:8];
        [callAgentView setCallAgentViewWithName:self.agentInfo.name mobile:mobileString txUrl:self.agentInfo.tx];
        [modal showContentView:callAgentView animated:YES];
        
        NSDictionary *param = @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                                @"id":self.agentInfo.idStr,
                                @"code":@" "
                                };
        [MBProgressHUD showMessage:@"正在接入,请稍后"];
        [YTHttpTool post:callAgentUrlStr params:param success:^(NSURLSessionDataTask *task, id responseObj) {
            NSLog(@"接通成功 %@",responseObj);
  
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"拨打失败"];
            NSLog(@"failed %@",error);
        }];
     
    }else{
        //验证界面
        verifyView = [EHVerifyView initVerifyView];
        verifyView.delegate = self;
        [verifyView setupCountdownBtn];
        [modal showContentView:verifyView animated:YES];

    }
}

# pragma mark - EHVerifyViewDelegate
- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];

    callAgentView = [EHCallAgentView initCallAgentView];
    [callAgentView setCallAgentViewWithName:self.agentInfo.name mobile:self.agentInfo.mobile txUrl:self.agentInfo.tx];
    STModal *modalCallAgent = [STModal modal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [modalCallAgent showContentView:callAgentView animated:YES];
        
        NSDictionary *param = @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                                @"id":self.agentInfo.idStr,
                                @"code":code
                                };
        [MBProgressHUD showMessage:@"正在接通电话中..."];
        [YTHttpTool post:callAgentUrlStr params:param success:^(NSURLSessionDataTask *task, id responseObj) {
            NSLog(@"接通成功  %@",responseObj);
            
        } failure:^(NSError *error) {
            [modal hide:YES];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"拨打失败"];
            NSLog(@"failed %@",error);
        }];

    });
    
}


# pragma mark - 分享点击
- (IBAction)shareBtnClick:(id)sender {
    OSMessage *msg=[[OSMessage alloc]init];
    //拼接分享页链接
    NSString *link = [NSString stringWithFormat:@"http://ehero.cc/agents/%@",self.agentInfo.idStr];
    msg.link = link;
    //链接标题
    NSString *title = [NSString stringWithFormat:@"为您分享经纪人:%@",self.agentInfo.name];
    msg.title = title;
    msg.desc = @"大数据推荐最匹配的经纪人";
    //分享的图标
    msg.image = UIImagePNGRepresentation(thumbImage);
    
    //分享界面弹窗
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈",@"微博",@"QQ好友", nil];
    NSMutableArray *picArray = [NSMutableArray arrayWithObjects:@"share_wechat",@"share_timeline",@"share_weibo",@"share_qq",nil];
    ShareView *share = [[ShareView alloc]initWithTitleArray:titleArray picArray:picArray];
    [share showShareView];
    
    [share currentIndexWasSelected:^(NSInteger index) {
        //它的index是从100开始数起，逐个加1
        if (index == 100) {
            [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message){
                NSLog(@"分享微信好友成功！");
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享微信好友失败!");
            }];
        }else if (index == 101){
            [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
                NSLog(@"微信分享到朋友圈成功：\n%@",message);
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
            }];
        }else if (index == 102){
            [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
                NSLog(@"分享到微博成功");
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到微博失败");
            }];
        }else{
            
            msg.thumbnail = UIImagePNGRepresentation(thumbImage);
            
            [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
                NSLog(@"分享到QQ好友成功");
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到QQ好友失败");
            }];
        
        }
        
    }];
    
}
# pragma mark - 收藏点击
- (IBAction)collectBtnClick:(id)sender {
    selectedFlag = !selectedFlag;
    if (selectedFlag) {
        self.collectBtn.selected = YES;
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        [self collect];
        
    }else{
        self.collectBtn.selected = NO;
        [self.agentInfo deleteObject];
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
        self.collectBtn.selected = NO;
    }else{
        self.collectBtn.selected = YES;
    }
    
}




#pragma mark - 浏览过的经纪人，不重复地存到数据库
- (void)skimedAndSave{
    
    EHSkimedAgentInfo *skimedAgent = [[EHSkimedAgentInfo alloc]init];
    [skimedAgent setWithAgentInfoAndTimeLabel:self.agentInfo];
    //    [skimedAgent save];
    
    NSString *sqlForName = [NSString stringWithFormat:@" WHERE name = '%@' ",self.agentInfo.name];
    EHSkimedAgentInfo *skimedAgentExisted = [EHSkimedAgentInfo findFirstByCriteria:sqlForName];
    
    //小于30条记录
    if ([EHSkimedAgentInfo findCounts] < 30) {
        //数据库里没有,直接插入
        if (skimedAgentExisted == nil) {
            NSLog(@"数据库里没有,直接插入");
            [skimedAgent save];
        //数据库里有
        }else{
            NSLog(@"数据库里有,先删再插");
            [skimedAgentExisted deleteObject];
            [skimedAgent save];
        }
        
    }
    //大于等于30条记录
    else{
        //大于30条里，数据库里没有
        if (skimedAgentExisted == nil) {
            NSLog(@"大于等于30条里，数据库里没有,删除第一条");
            NSString *sqlForName = [NSString stringWithFormat:@" LIMIT 1 OFFSET 0 "];
            [[EHSkimedAgentInfo findFirstByCriteria:sqlForName] deleteObject];;
            [skimedAgent save];
            
        }else{
        //大于30条里，数据库里有
            NSLog(@"大于30条里，数据库里有,删除原来的，重新插入");
            [skimedAgentExisted deleteObject];
            [skimedAgent save];
        }
        
    }

}

#pragma mark - 监听电话回调
- (void)callCallBack
{
    callCenter = [[CTCallCenter alloc] init];
    __weak STModal *weakmodal = modal;
    callCenter.callEventHandler = ^(CTCall* call) {
        if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
            [MBProgressHUD hideHUD];
            [weakmodal hide:YES];
        }
    };
}

@end
