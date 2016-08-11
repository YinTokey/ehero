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
@interface EHAgentInfoController ()<EHSearchResultCellDelegate,EHVerifyViewDelegate>
{
    EHCallAgentView *callAgentView;
    STModal *modal;
    EHVerifyView *verifyView;
}
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

//@property (strong, nonatomic)
@end

@implementation EHAgentInfoController{
    UIImage *thumbImage;
    NSInteger selectedFlag;
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
    
//    NSLog(@"数据总数 %ld",[EHSkimedAgentInfo findCounts]);
    [self skimedAndSave];

    

}

- (void)viewWillAppear:(BOOL)animated{
   // [self isCollected];
    
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1){
        return 115;
    }else{
        return 125;
//        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];
//        cell.translatesAutoresizingMaskIntoConstraints = NO;
//        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        return 1  + size.height;
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
        //cell.userInteractionEnabled = NO;
        cell.isdrawRect = NO;
        cell.delegate = self;
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
    
    callAgentView = [EHCallAgentView initCallAgentView];
    //修改电话号码格式
    NSMutableString *mobileString = [NSMutableString stringWithString:self.agentInfo.mobile];
    [mobileString insertString:@"-" atIndex:3];
    [mobileString insertString:@"-" atIndex:8];
    
    [callAgentView setCallAgentViewWithName:self.agentInfo.name mobile:mobileString txUrl:self.agentInfo.tx];
    
    
    verifyView = [EHVerifyView initVerifyView];
    verifyView.delegate = self;
    [verifyView setupCountdownBtn];
    [modal showContentView:verifyView animated:YES];
}
# pragma mark - EHVerifyViewDelegate
- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];

    callAgentView = [EHCallAgentView initCallAgentView];
    [callAgentView setCallAgentViewWithName:self.agentInfo.name mobile:self.agentInfo.mobile txUrl:self.agentInfo.tx];
    STModal *modalCallAgent = [STModal modal];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [modalCallAgent showContentView:callAgentView animated:YES];
        [MBProgressHUD showNormalMessage:@"正在接通电话" toView:nil];
        
        
        NSDictionary *param = @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                                @"id":self.agentInfo.idStr,
                                @"code":code};
        [YTHttpTool post:callAgentUrlStr params:param success:^(id responseObj) {
            NSLog(@"success %@",responseObj);
            [modalCallAgent hide:YES];
            
        } failure:^(NSError *error) {
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
    selectedFlag ++;
    if (selectedFlag %2 == 1) {
        self.collectBtn.selected = YES;
        [self.view makeToast:@"收藏成功" duration:1.0 position:CSToastPositionCenter];
        [self collect];
        
    }else{
        self.collectBtn.selected = NO;
        [self.view makeToast:@"取消收藏" duration:1.0 position:CSToastPositionCenter];
    }

}

- (void)collect{
    [self.agentInfo save];
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



@end
