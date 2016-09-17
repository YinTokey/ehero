//
//  UIImage+Cut.m
//  易房好介
//
//  Created by Mac on 16/9/18.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "UIImage+Cut.h"

@implementation UIImage (Cut)

+(UIImage *)rectImageWithImageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth{
    
    // 获取要裁剪的图片
    UIImage *img = [UIImage imageNamed:imageName];
    CGRect imgRect = CGRectMake(0, 0, img.size.width, img.size.height);
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    CGContextRef bitmapContext = UIGraphicsGetCurrentContext();
    CGContextAddRect(bitmapContext,CGRectMake(0, 0, img.size.width, img.size.height));
    CGContextClip(bitmapContext);
    // 2.2 添加图片
    [img drawInRect:imgRect];
    
    // 3.获取当前位图上下文的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束位图编辑
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
