//
//  EHVerifyView.m
//  ehero
//
//  Created by Mac on 16/8/5.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHVerifyView.h"
#import "MZTimerLabel.h"
#import "YTHttpTool.h"
#import "EHRegularExpression.h"
@interface EHVerifyView()<MZTimerLabelDelegate>
{
    CGRect resendBtnRect;
}
- (IBAction)callBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *myPhoneNumber;
@property (nonatomic,strong) UIButton *sendCodeBtn;
@property (nonatomic,strong)MZTimerLabel *timer;


@end

@implementation EHVerifyView

+ (instancetype)initVerifyView{
    
    EHVerifyView *verifyView = [[[NSBundle mainBundle] loadNibNamed:@"EHVerifyView" owner:nil options:nil] lastObject];

    return verifyView;
}

- (void)setupCountdownBtn{
    UIButton *sendCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.myPhoneNumber.bounds.size.width / 3.5, self.myPhoneNumber.bounds.size.height)];
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
    self.sendCodeBtn =  sendCodeBtn;
    
    
    self.myPhoneNumber.rightView = _sendCodeBtn;
    self.myPhoneNumber.rightViewMode = UITextFieldViewModeAlways;
    //添加边框
    self.code.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.myPhoneNumber.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    [self setTimer];
}

- (void)setTimer{
    self.timer = [[MZTimerLabel alloc] initWithLabel:self.sendCodeBtn.titleLabel andTimerType:MZTimerLabelTypeTimer];
    self.timer.timeFormat = @"ss 秒";
    [self.timer setCountDownTime:60];
    //设置代理
    self.timer.delegate = self;
}


- (void)sendClick{
    
    if ([self.timer counting]) {
        //如果正在计时，则按钮不可点击
        self.sendCodeBtn.alpha = 0.7;
        self.sendCodeBtn.userInteractionEnabled = NO;
        
    }else{
        //正则表达式判断电话号码，电话格式正确，才可以发送
        if ([EHRegularExpression validateMobile:self.myPhoneNumber.text ]) {
            self.sendCodeBtn.userInteractionEnabled = YES;
            [self.sendCodeBtn setFrame:CGRectMake(self.myPhoneNumber.bounds.size.width - self.sendCodeBtn.bounds.size.width, 0, self.myPhoneNumber.bounds.size.width / 6, self.myPhoneNumber.bounds.size.height)];
            [self.timer start];
            //计时启动后不可点击
            self.sendCodeBtn.alpha = 0.7;
            self.sendCodeBtn.userInteractionEnabled = NO;
            [self sendCodeRequest];
            
        }else{
        //电话格式填写错误，不能点击发送按钮
            [MBProgressHUD showError:@"电话格式错误" toView:self];
        }
        
    }
  
}

#pragma mark - 倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    //宽度变化
    [self.sendCodeBtn setFrame:resendBtnRect];
    //可以点击
    self.sendCodeBtn.alpha = 1;
    self.sendCodeBtn.userInteractionEnabled = YES;
    [self.sendCodeBtn setTitle:@"重新发送验证码" forState:UIControlStateNormal];
    [self.sendCodeBtn.titleLabel setFont:[UIFont systemFontOfSize: 14.0]];
    NSLog(@"倒计时结束");
}

- (void)sendCodeRequest{
    
        NSDictionary *params = @{@"mobile":self.myPhoneNumber.text};
        [YTHttpTool post:sendCodeUrlStr params:params success:^(id responseObj) {
            NSLog(@"success");
        } failure:^(NSError *error) {
            NSLog(@"faild,%@",error);
        }];
}

- (IBAction)callBtnClick:(id)sender {
    [MBProgressHUD showError:@"暂时无法呼叫" toView:self];
}





@end
