//
//  EHChangeOffsetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHChangeOffsetViewModel.h"

@implementation EHChangeOffsetViewModel

- (void)changeOffsetWithTextView:(UITextView *)textView superView:(UIView *)superView{
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 0 - (superView.frame.size.height - 263.0);//iPhone键盘高度216，iPad的为352,这里设成263更方便，并且考虑到搜狗的键盘比系统的键盘高一点
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.5f];
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset < -15)
        superView.frame = CGRectMake(0.0f, offset, superView.frame.size.width, superView.frame.size.height);
    [UIView commitAnimations];

}


@end
