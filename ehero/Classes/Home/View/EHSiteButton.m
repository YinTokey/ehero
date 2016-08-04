//
//  EHSiteButton.m
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSiteButton.h"
#define ImageW 10//图片的宽度
@implementation EHSiteButton

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //设置图片的显示样式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    return self;
    
}

//设置标题的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleW = contentRect.size.width - ImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(0, 0, titleW, titleH);
}

//设置图片的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = ImageW;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - ImageW;
    //self.imageView.contentMode = UIViewContentModeCenter;
#warning 在此方法，UIButton的子控件都是空，不能在此地设置图片的显示样式
    
    //NSLog(@"%@",self.imageView);
    return CGRectMake(imageX, 0, imageW, imageH);
    
}


@end
