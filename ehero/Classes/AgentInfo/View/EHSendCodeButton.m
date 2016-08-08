//
//  EHSendCodeButton.m
//  ehero
//
//  Created by Mac on 16/8/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSendCodeButton.h"

@implementation EHSendCodeButton

+ (instancetype)initWithAction:(SEL)sendClick frame:(CGRect)frame superView:(UIView *)superView{
    EHSendCodeButton *sendCodeBtn = [[EHSendCodeButton alloc]initWithFrame:frame];
    CGRect resendBtnRect;
    //获取按钮大小
    resendBtnRect = sendCodeBtn.frame;
    // +25 是重新发送验证码的按钮宽度
    resendBtnRect.size.width = resendBtnRect.size.width + 25;
    
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    sendCodeBtn.titleLabel.textColor = [UIColor whiteColor];
    [sendCodeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    [sendCodeBtn setBackgroundImage:[UIImage imageNamed:@"sendCodeBtn"] forState:UIControlStateNormal];

    [sendCodeBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    return sendCodeBtn;
}

- (void)sendClick{
    NSLog(@"来自封装的点击");
}
@end
