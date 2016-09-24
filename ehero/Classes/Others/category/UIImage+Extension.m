//
//  UIImage+Extensiton.m
//  A01-QQ聊天列表
//
//  Created by Apple on 14/12/21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (instancetype)resizeImage:(NSString *)imgName
{
    UIImage *bgImage =  [UIImage imageNamed:imgName];
    //缩放图片
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width / 2 topCapHeight:bgImage.size.height / 2];
    return bgImage;
}
@end
