//
//  EHSearchBar.m
//  ehero
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchBar.h"

@implementation EHSearchBar

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self searchbar];
    }
    return self;
}





- (void)searchbar{

    //设置textField的样式
    self.borderStyle = UITextBorderStyleNone;
    //设置键盘的return键 的样式 我们更改为search字样
    self.returnKeyType = UIReturnKeySearch;
    //背景图
    self.background = [UIImage imageNamed:@"home_bar_frame"];
   //创建imageView对象
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    //设置 imgVIew的用户可交互性
    imgView.userInteractionEnabled = YES;
    //给 imgView赋值  tabbar_discover是一个放大镜图片
    imgView.image = [UIImage imageNamed:@"search_icon"];
    //设置self (textField)的 rightView属性和 rightViewMode的属性
    self.rightView = imgView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
