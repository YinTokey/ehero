//
//  EHAntidisturbViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAntidisturbViewController.h"
#import "EHRegularExpression.h"
#import "EHCookieOperation.h"
#import "STModal.h"
#import "EHVerifyView.h"
#import "EHAntiDisturbNetViewModel.h"

#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>

@interface EHAntidisturbViewController ()<UITextFieldDelegate,EHVerifyViewDelegate>
{
    STModal *modal;
    EHVerifyView *verifyView;
    CTCallCenter *callCenter;
}

@property (nonatomic,strong) EHAntiDisturbNetViewModel *antiDisturbNetViewModel;

@property (weak, nonatomic) IBOutlet UIView *verifiedView;
@property (weak, nonatomic) IBOutlet UITextField *verifiedOtherPhone;
@property (nonatomic,copy) NSString *code;
- (IBAction)verifiedCallClick:(id)sender;

@end

@implementation EHAntidisturbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化弹窗配置
    modal = [STModal modal];
    modal.hideWhenTouchOutside = YES;
 
    [self addGesture];
    self.verifiedOtherPhone.delegate = self;
 
    [self callCallBack];
    
    [YTHttpTool netCheck];
    
    _antiDisturbNetViewModel = [[EHAntiDisturbNetViewModel alloc]init];
    
}

- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];
    self.code = code;
    
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
    [self.verifiedOtherPhone resignFirstResponder];
}

#pragma mark  - uiTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.verifiedOtherPhone resignFirstResponder];
    return YES;
}


- (void)cookieCheck{
    //如果有cookie，读取cookie
    if ([EHCookieOperation setCookie]) {
        //打电话
        if (_code.length > 2) {
            [ _antiDisturbNetViewModel callAgentWithPhoneText:self.verifiedOtherPhone.text super:self code:self.code];
        }else{
            [ _antiDisturbNetViewModel callAgentWithPhoneText:self.verifiedOtherPhone.text super:self code:@" "];
        }
        
    }else{
        [self popVerifyView];
    }
}

- (void)popVerifyView{
    //验证界面
    verifyView = [EHVerifyView initVerifyView];
    verifyView.delegate = self;
    [verifyView setupCountdownBtn];
    [modal showContentView:verifyView animated:YES];
}

- (IBAction)verifiedCallClick:(id)sender {
 
    [self cookieCheck];
}

- (void)callCallBack
{
    callCenter = [[CTCallCenter alloc] init];
    __weak EHAntidisturbViewController *weakself = self;
    callCenter.callEventHandler = ^(CTCall* call) {
        if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
            [MBProgressHUD hideHUDForView:weakself.view];
        }
    };
}


@end
