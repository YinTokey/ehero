//
//  EHSocialShareViewModel.m
//  ehero
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSocialShareViewModel.h"
#import <OpenShareHeader.h>


@implementation EHSocialShareViewModel

- (void)shareWithIndex:(NSInteger)index{
    //初始化分享图标
    UIImage *thumbImage = [UIImage imageNamed:@"share_icon"];
    OSMessage *msg=[[OSMessage alloc]init];
    //拼接分享页链接
  //  NSString *link = [NSString stringWithFormat:@"http://ehero.cc/agents/%@",idStr];
    msg.link = self.link;
    //链接标题
   // NSString *title = [NSString stringWithFormat:@"为您分享经纪人:%@",agentName];
    msg.title = self.title;
    msg.desc = self.desc;
    //分享的图标
    msg.image = UIImagePNGRepresentation(thumbImage);
    
    
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
        if (self.shareToQzoneFlag == YES) {
            [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
                NSLog(@"分享到QQ空间成功");
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到QQ空间失败");
            }];
        }else{
            [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
                NSLog(@"分享到微博成功");
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到微博失败");
            }];
        }
    }else{
        
        msg.thumbnail = UIImagePNGRepresentation(thumbImage);
        
        [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
            NSLog(@"分享到QQ好友成功");
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"分享到QQ好友失败");
        }];
        
    }

}

@end
