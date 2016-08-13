//
//  EHAntidisturbViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAntidisturbViewController.h"
#import <WebKit/WebKit.h>
#import "MZTimerLabel.h"
#import "YTHttpTool.h"
#import "EHRegularExpression.h"
#import "EHCookieOperation.h"

@interface EHAntidisturbViewController ()<WKNavigationDelegate,MZTimerLabelDelegate,UITextFieldDelegate>
{
    CGRect resendBtnRect;
}
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *callClick;
@property (weak, nonatomic) IBOutlet UITextField *myPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *otherPhone;
@property (nonatomic,strong)MZTimerLabel *timer;
@property (nonatomic,strong) UIButton *sendCodeBtn;
- (IBAction)CALL:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *verifiedView;
@property (weak, nonatomic) IBOutlet UITextField *verifiedOtherPhone;
- (IBAction)verifiedCallClick:(id)sender;

@property (nonatomic,strong)WKWebView *webView;



@end

@implementation EHAntidisturbViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCountdownBtn];

    [self cookieCheck];
    
 
}

- (void)cookieCheck{
    //如果有cookie，读取cookie
    if ([EHCookieOperation setCookie]) {
        self.backView.hidden = YES;
        
    }else{
        self.verifiedView.hidden = YES;
    }
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
    [self addGesture];
    self.myPhoneNumber.delegate =  self;
    self.code.delegate = self;

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
            [MBProgressHUD showError:@"电话格式错误" toView:self.view];
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
    [YTHttpTool post:sendCodeUrlStr params:params success:^(NSURLSessionDataTask *task,id responseObj) {
        NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"faild,%@",error);
    }];
}

- (void)addGesture{
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

#pragma mark  - UITapGestureRecognizer
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.myPhoneNumber resignFirstResponder];
    [self.code resignFirstResponder];
    [self.otherPhone resignFirstResponder];
    [self.verifiedOtherPhone resignFirstResponder];
}

#pragma mark  - uiTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.myPhoneNumber resignFirstResponder];
    [self.code resignFirstResponder];
    [self.otherPhone resignFirstResponder];
    [self.verifiedOtherPhone resignFirstResponder];
    return YES;
}


- (IBAction)CALL:(id)sender {
    
    NSDictionary *params = @{@"code":self.code.text};
    [YTHttpTool get:codeCheckUrlStr params:params  success:^(NSURLSessionDataTask *task, id responseObj) {
        
        //block嵌套，先验证后打电话
        [MBProgressHUD showSuccess:@"验证成功"];
        [EHCookieOperation saveCookieWithDate:[NSDate date]];
        
        [self callAction];

    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"验证出错"];
        NSLog(@"failed %@",error);
   
    }];
    
}
# pragma mark - 打电话请求
- (void)callAction{
    NSDictionary *helper = [NSDictionary dictionary];
    if ([EHCookieOperation setCookie]) {
        helper = @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                   @"code":@"",
                   @"to":self.verifiedOtherPhone.text};
        
    }else{
        helper = @{@"from":self.myPhoneNumber.text,
                   @"code":self.code.text,
                   @"to":self.otherPhone.text};
    }
    NSDictionary *param = @{@"helper":helper};
    [MBProgressHUD showMessage:@"正在接入，请稍后"];
    
    [YTHttpTool post:anti_disturbCallUrlStr params:param success:^(NSURLSessionDataTask *task,id responseObj) {
        NSLog(@"success call %@",responseObj);

    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"拨打失败"];
        NSLog(@"failed call %@",error);

    }];
}
- (IBAction)verifiedCallClick:(id)sender {
    [self callAction];
}



@end
