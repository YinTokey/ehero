//
//  EHVerifyView.m
//  ehero
//
//  Created by Mac on 16/8/5.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHVerifyView.h"
#import "MZTimerLabel.h"


@interface EHVerifyView()

- (IBAction)callBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *myPhoneNumber;
@property (nonatomic,strong) UIButton *sendCodeBtn;


@end

@implementation EHVerifyView

+ (instancetype)initVerifyView{
    
    EHVerifyView *verifyView = [[[NSBundle mainBundle] loadNibNamed:@"EHVerifyView" owner:nil options:nil] lastObject];
    
    return verifyView;
}

- (void)setupCountdownBtn{
    UIButton *sendCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.myPhoneNumber.bounds.size.width / 3.5, self.myPhoneNumber.bounds.size.height)];
    [sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    sendCodeBtn.titleLabel.textColor = [UIColor whiteColor];
    [sendCodeBtn setBackgroundImage:[UIImage imageNamed:@"sendCodeBtn"] forState:UIControlStateNormal];
    [sendCodeBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    self.sendCodeBtn =  sendCodeBtn;
    
    
    self.myPhoneNumber.rightView = _sendCodeBtn;
    self.myPhoneNumber.rightViewMode = UITextFieldViewModeAlways;
    //添加边框
    self.code.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.myPhoneNumber.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
}

- (void)sendClick{
    NSLog(@"发验证码测试");
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.sendCodeBtn.titleLabel andTimerType:MZTimerLabelTypeTimer];
    timer.timeFormat = @"ss 秒";
    [timer setCountDownTime:60];
    
    [self.sendCodeBtn setFrame:CGRectMake(0, 0, self.myPhoneNumber.bounds.size.width / 6, self.myPhoneNumber.bounds.size.height)];
    
    [timer start];
    
    
}

- (IBAction)callBtnClick:(id)sender {
}
@end
