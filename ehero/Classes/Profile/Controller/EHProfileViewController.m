//
//  EHProfileViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHProfileViewController.h"
#import <OpenShareHeader.h>
@interface EHProfileViewController ()

@end

@implementation EHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"最近浏览的经纪人";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"最近浏览的房源";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"收藏的锦囊";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"收藏的经纪人";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"手机登录";
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"联系我们";
    }
    else if (indexPath.row == 6) {
        cell.textLabel.text = @"关于我们";
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OSMessage *msg=[[OSMessage alloc]init];
    msg.title=@"Hello msg.title";
    
    if (indexPath.row == 0) {
        [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
            NSLog(@"微信分享到朋友圈成功：\n%@",message);
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
        }];
    }else{
        [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
            NSLog(@"分享到微博成功");
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"分享到微博失败");
        }];
    
    
    }
    
    

}

@end
