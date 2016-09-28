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
#import "EHStorageViewModel.h"
#import "AppDelegate.h"
@interface EHAntidisturbViewController ()<UITextFieldDelegate,EHVerifyViewDelegate>
{
    STModal *modal;
    EHVerifyView *verifyView;
    CTCallCenter *callCenter;
}

@property (nonatomic,strong) EHAntiDisturbNetViewModel *antiDisturbNetViewModel;
@property (nonatomic,strong) EHStorageViewModel *storeViewModel;

@property (weak, nonatomic) IBOutlet UITextField *verifiedOtherPhone;
@property (nonatomic,copy) NSString *code;
- (IBAction)verifiedCallClick:(id)sender;

@end

@implementation EHAntidisturbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YTHttpTool netCheck];
    //初始化弹窗配置
    modal = [STModal modal];
    modal.hideWhenTouchOutside = YES;
 
    [self addGesture];
    self.verifiedOtherPhone.delegate = self;
 
    [self callCallBack];
    _antiDisturbNetViewModel = [[EHAntiDisturbNetViewModel alloc]init];
    _storeViewModel = [[EHStorageViewModel alloc]init];
}

- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];
    self.code = code;
    [_storeViewModel storeCode:code];
    
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
    [YTHttpTool netCheck];
    //如果有cookie，读取cookie
    if ([EHRegularExpression validateMobile:self.verifiedOtherPhone.text ]){
        if ([EHCookieOperation setCookie]) {
            //打电话，本页完成验证
            if (_code.length > 2) {
                [ _antiDisturbNetViewModel callAgentWithPhoneText:self.verifiedOtherPhone.text super:self code:self.code];
            }else{
                NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
                NSDictionary *codeDic = [defualts objectForKey:@"codeDic"];
                //在评论界面完成验证
                if (codeDic) {
                    NSDate *dateNow = [NSDate date];
                    NSDate *codeDate = [codeDic objectForKey:@"date"];
                    NSTimeInterval interval = [dateNow timeIntervalSinceDate:codeDate];
                    NSInteger resultInterval = ((NSInteger)interval);
                    if(resultInterval <= 24*3600 ){  //24小时内，直接用
                         [ _antiDisturbNetViewModel callAgentWithPhoneText:self.verifiedOtherPhone.text super:self code:[codeDic objectForKey:@"code"]];
                    }else{
                        [self popVerifyView];
                    }
                }else{
                //在经纪人详情页完成验证
                    [ _antiDisturbNetViewModel callAgentWithPhoneText:self.verifiedOtherPhone.text super:self code:@" "];
                }
            }
        }else{
            [self popVerifyView];
        }
    }else{
        [MBProgressHUD showError:@"电话号码格式错误" toView:self.view];
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
