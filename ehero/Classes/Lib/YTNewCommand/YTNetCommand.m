//
//  YTNetCommand.m
//  每日烹
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTNetCommand.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"


@interface NSObject()


@end

@implementation YTNetCommand

//  下载图片
+(UIImage *)downloadImageWithImgStr:(NSString *)imgUrlStr placeholderImageStr:(NSString *)placeholderImageStr imageView:(UIImageView *)imageView{

    [imageView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:placeholderImageStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      //  NSLog(@"cacheType:%ld",(long)cacheType);
      //  NSLog(@"imageurl:%@",imageURL);
       // NSLog(@"done %@",image);
    }];

    UIImage *img = imageView.image;
    return img;
    
}




@end
