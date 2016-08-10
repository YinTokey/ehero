//
//  UIButton+GetWidth.m
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "UIButton+GetWidth.h"

@implementation UIButton (GetWidth)

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    button.titleLabel.text = title;
    button.titleLabel.font = font;
    [button.titleLabel sizeToFit];
    return button.titleLabel.frame.size.width;
}


@end
