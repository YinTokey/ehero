//
//  EHAntidisturbViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAntidisturbViewController.h"
#import "YTHttpTool.h"
#import "EHRegularExpression.h"
#import "EHCookieOperation.h"
#import "STModal.h"
#import "EHVerifyView.h"
@interface EHAntidisturbViewController ()<UITextFieldDelegate,EHVerifyViewDelegate>
{
    STModal *modal;
    EHVerifyView *verifyView;
}

@property (weak, nonatomic) IBOutlet UIView *verifiedView;
@property (weak, nonatomic) IBOutlet UITextField *verifiedOtherPhone;
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
    
}

- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];
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


# pragma mark - 打电话请求
- (void)callAction{
  // [MBProgressHUD showMessage:@"正在接入，请稍后"];
   //
    NSDictionary *helper =  @{@"from":[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoneNumber"],
                              @"code":@"",
                              @"to":self.verifiedOtherPhone.text};

    NSDictionary *param = @{@"helper":helper};
       
    [YTHttpTool post:anti_disturbCallUrlStr params:param success:^(NSURLSessionDataTask *task,id responseObj) {
       NSLog(@"呼叫成功 %@",responseObj);
            
    } failure:^(NSError *error) {
   //    [MBProgressHUD hideHUD];
       [MBProgressHUD showError:@"拨打失败"];
       NSLog(@"呼叫失败 %@",error);
  }];

}


- (void)cookieCheck{
    //如果有cookie，读取cookie
    if ([EHCookieOperation setCookie]) {
       // [MBProgressHUD showMessage:@"正在接通电话中..."];
        [self callAction];
        
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
    [MBProgressHUD showMessage:@"正在接通电话中..."];
    [self cookieCheck];
}



@end
