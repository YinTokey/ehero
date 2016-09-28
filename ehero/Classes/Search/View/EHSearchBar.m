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

// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}



- (void)searchbar{

    //设置textField的样式
    self.borderStyle = UITextBorderStyleNone;
    //设置键盘的return键 的样式 我们更改为search字样
    self.returnKeyType = UIReturnKeySearch;
    //背景图
    self.background = [UIImage imageNamed:@"home_bar_frame"];

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
    [button setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = button;
    
    
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)searchClick{
    if ([self.EHSearchBtndelegate respondsToSelector:@selector(searchBtnClick)]) {
        [self.EHSearchBtndelegate searchBtnClick];
    }

}

@end
