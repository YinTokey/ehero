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
@interface EHAgentInfoController ()
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end

@implementation EHAgentInfoController{
    UIImage *thumbImage;
    NSInteger selectedFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.name;
    self.view.backgroundColor = RGB(241, 243, 245);
    
    thumbImage = [UIImage imageNamed:@"share_icon"];

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
        EHAgentInfo *agentInfo = [EHAgentInfo setWithAgentInfoController:self];
        [cell setResultCell:agentInfo];
        return cell;
    }else if(indexPath.section == 1){
        EHAgentInfoCommunityCell *cell = [EHAgentInfoCommunityCell AgentInfoCommunityCellWithTableView:tableView];
        return cell;
    }else{
        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];

        return cell;
    
    }

}

- (IBAction)shareBtnClick:(id)sender {
    OSMessage *msg=[[OSMessage alloc]init];
    //拼接分享页链接
    NSString *link = [NSString stringWithFormat:@"http://ehero.cc/agents/%@",self.idStr];
    msg.link = link;
    //链接标题
    NSString *title = [NSString stringWithFormat:@"为您分享经纪人:%@",self.name];
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

- (IBAction)collectBtnClick:(id)sender {
    selectedFlag ++;
    if (selectedFlag %2 == 1) {
        self.collectBtn.selected = YES;
        [MBProgressHUD showSuccess:@"收藏成功"];
    }else{
        self.collectBtn.selected = NO;
        [MBProgressHUD showSuccess:@"取消收藏"];
    }

}
@end
