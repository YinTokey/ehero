//
//  UIBarButtonItem+Extension.m
//  ehero
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                target:(id)target
                                action:(SEL)action {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)]; //后期加入ipad，这个要调整
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
//    button.imageView.image = [UIImage imageNamed:@"triangle_down"];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}
@end
