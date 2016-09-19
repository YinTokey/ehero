//
//  UIImage+Cut.m
//  Pods
//
//  Created by Mac on 16/9/18.
//
//

#import "UIImage+Cut.h"

@implementation UIImage (Cut)

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

+(UIImage *)rectImageWithImage:(UIImage *)originImg clipRect:(CGRect)clipRect{
    
    // 获取要裁剪的图片
    UIImage *img = originImg;
    CGRect imgRect = CGRectMake(0, 0, img.size.width, img.size.height);
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    CGContextRef bitmapContext = UIGraphicsGetCurrentContext();
    CGContextAddRect(bitmapContext,clipRect);
    CGContextClip(bitmapContext);
    // 2.2 添加图片
    [img drawInRect:imgRect];
    
    // 3.获取当前位图上下文的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束位图编辑
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}
@end
