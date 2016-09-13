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


#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>
@interface EHAgentInfoController ()<EHVerifyViewDelegate>
{
    EHCallAgentView *callAgentView;
    EHVerifyView *verifyView;
    CTCallCenter *callCenter;
}
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

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

    [self isCollected];
    [self callCallBack];
    [self initViewModels];
    
    [self transData];
    
    //数据传递
    [_agentInfoNetViewModel getAverageInfo:^(EHAverageInfo *averageInfo){
        _agentInfoTableViewModel.averageInfo = averageInfo;
        
    }];
}


- (void)initViewModels{
    _socialViewModel = [[EHSocialShareViewModel alloc]init];
    _agentInfoTableViewModel = [[EHAgentInfoTableViewModel alloc]init];
    _agentInfoTableViewModel.agentInfo = self.agentInfo;
    _agentInfoTableViewModel.superVC = self;
    _agentInfoTableViewModel.commentsArray = [NSMutableArray array];
    
    self.tableView.dataSource = _agentInfoTableViewModel;
    self.tableView.delegate = _agentInfoTableViewModel;
    
    _agentInfoNetViewModel = [[EHAgentInfoNetViewModel alloc]init];
    _agentInfoNetViewModel.superVC = self;
    
    
    _skimedAgentViewModel = [[EHSkimedAgentViewModel alloc]init];
    [_skimedAgentViewModel skimedAndSaveWithAgentInfo:self.agentInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

# pragma mark - searchResultCellDelegate
- (void)callBtnClick:(UITableViewCell *)cell{
    //如果有cookie
    if ([EHCookieOperation setCookie]) {
        NSLog(@"有cookie,设置成功，不用再验证");
        [self showCallAgentView];
        [_agentInfoNetViewModel callAgentWithIdStr:self.agentInfo.idStr code:@"" failure:^{
            [_modal hide:YES];
         }];
    }else{
        //验证界面
        verifyView = [EHVerifyView initVerifyView];
        verifyView.delegate = self;
        [verifyView setupCountdownBtn];
        [_modal showContentView:verifyView animated:YES];

    }
}

# pragma mark - EHVerifyViewDelegate
- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [_modal hide:YES];
    
    [self showCallAgentView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_modal showContentView:callAgentView animated:YES];
        
        [_agentInfoNetViewModel callAgentWithIdStr:self.agentInfo.idStr code:code failure:^{
            [_modal hide:YES];
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
    __weak STModal *weakmodal = _modal;
    callCenter.callEventHandler = ^(CTCall* call) {
        if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
            [MBProgressHUD hideHUD];
            [weakmodal hide:YES];
        }
    };
}
#pragma mark - 传递假数据
- (void)transData{
    /*
    //1.1 加载模型数据
    EHCommentInfo *commentInfo = [[EHCommentInfo alloc]init];
    commentInfo.author = @"15695951989";
    commentInfo.text = @"这是第一条评论";
    
    EHCommentInfo *commentInfo1 = [[EHCommentInfo alloc]init];
    commentInfo1.text = @"这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论这是第二条评论";
    commentInfo1.author = @"15695951988";
    
    EHCommentInfo *commentInfo2 = [[EHCommentInfo alloc]init];
    commentInfo2.text = @"这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条这是第三条";
    commentInfo2.author = @"15695951989";
    
    EHCommentInfo *commentInfo3 = [[EHCommentInfo alloc]init];
    commentInfo3.text = @"这是第四条这";
    commentInfo3.author = @"15695951989";

    [_agentInfoTableViewModel.commentsArray addObject:commentInfo];
    [_agentInfoTableViewModel.commentsArray addObject:commentInfo1];
    [_agentInfoTableViewModel.commentsArray addObject:commentInfo2];
    [_agentInfoTableViewModel.commentsArray addObject:commentInfo3];
     */
    
    
    
    
}

@end
