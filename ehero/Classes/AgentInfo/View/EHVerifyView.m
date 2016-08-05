//
//  EHVerifyView.m
//  ehero
//
//  Created by Mac on 16/8/5.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHVerifyView.h"

@interface EHVerifyView()

- (IBAction)callBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *myPhoneNumber;


@end

@implementation EHVerifyView

+ (instancetype)initVerifyView{
    
    EHVerifyView *verifyView = [[[NSBundle mainBundle] loadNibNamed:@"EHVerifyView" owner:nil options:nil] lastObject];
    
    return verifyView;
}

- (void)setupCountdownBtn{
    UIButton *sendCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.myPhoneNumber.bounds.size.width / 4, self.myPhoneNumber.bounds.size.height)];
    sendCodeBtn.titleLabel.text = @"发送验证码";
    sendCodeBtn.titleLabel.tintColor = [UIColor whiteColor];
    sendCodeBtn.backgroundColor = RGB(89, 182, 210);
    [sendCodeBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    self.myPhoneNumber.rightView = sendCodeBtn;
    self.myPhoneNumber.rightViewMode = UITextFieldViewModeAlways;

}

- (void)sendClick{
    NSLog(@"发验证码测试");

}

- (IBAction)callBtnClick:(id)sender {
}
@end
