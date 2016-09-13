//
//  EHCommentAgentDelegate.m
//  ehero
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentDelegate.h"



@implementation EHCommentAgentDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self changeOffsetWithTextView:textView superView:self.superView];
}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.superView.frame =CGRectMake(0, 0, self.superView.frame.size.width, self.superView.frame.size.height);
}

#pragma mark - textview 点击回车 键盘消失
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}

- (void)changeOffsetWithTextView:(UITextView *)textView superView:(UIView *)superView{
//    CGRect frame = textView.frame;
//    int offset = frame.origin.y - (superView.frame.size.height - 240.0);//iPhone键盘高度216，iPad的为352,这里设成263更方便，并且考虑到搜狗的键盘比系统的键盘高一点
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:0.5f];
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset < -15)
//    superView.frame = CGRectMake(0.0f, offset, superView.frame.size.width, superView.frame.size.height);
//    [UIView commitAnimations];
    
}


@end
