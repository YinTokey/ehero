//
//  UIImage+Cut.h
//  Pods
//
//  Created by Mac on 16/9/18.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Cut)

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (UIImage *)rectImageWithImage:(UIImage *)originImg clipRect:(CGRect)clipRect;

+ (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect;
@end
