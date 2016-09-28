//
//  EHCommentAgentViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentViewController.h"
#import "YTNetCommand.h"
#import "STModal.h"
#import "EHVerifyView.h"
#import "EHCookieOperation.h"
#import "SWTextView.h"
#import "EHCommentAgentNetViewModel.h"
#import "EHCommentAgentDelegate.h"
#import "EHStorageViewModel.h"

@interface EHCommentAgentViewController ()<UITextFieldDelegate,EHVerifyViewDelegate>
{
    STModal *modal;
    EHVerifyView *verifyView;
}

@property (nonatomic,strong) EHCommentAgentDelegate *commentAgentDelegate;
@property (nonatomic,strong) EHCommentAgentNetViewModel *commentAgentNetViewModel;
@property (nonatomic,strong) EHStorageViewModel *storeViewModel;

@property (weak, nonatomic) IBOutlet UITextField *communityTextField;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet SWTextView *commentView;
@property (weak, nonatomic) IBOutlet UIImageView *txImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *rates;
@property (weak, nonatomic) IBOutlet UIButton *negativeComment;
@property (weak, nonatomic) IBOutlet UIButton *moderateComment;
@property (weak, nonatomic) IBOutlet UIButton *highPraise;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;


- (IBAction)highPriseClick:(id)sender;
- (IBAction)moderateClick:(id)sender;
- (IBAction)negativeClick:(id)sender;
- (IBAction)commitBtnClick:(id)sender;

@end

@implementation EHCommentAgentViewController
{
    NSString *commentKind;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommentViewFrame];
    [self addGesture];
    [self setCornerRadius];
    
    [self initViewModels];
    
    self.commentView.delegate = _commentAgentDelegate;
    //textview从顶开始显示
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.communityTextField.delegate = self;
    //联网状态监测
    [YTHttpTool netCheck];

    //初始化弹窗配置
    modal = [STModal modal];
    modal.hideWhenTouchOutside = YES;
    
    [self setupNavBar];
    [self loadResultWithAgentInfo:self.agentInfo];
    
    self.commentView.autoAdjustLayoutView = self.view;
}

- (void)initViewModels{
    _commentAgentDelegate = [[EHCommentAgentDelegate alloc]init];
    _commentAgentDelegate.superView = self.view;
    _commentAgentNetViewModel = [[EHCommentAgentNetViewModel alloc]init];
    _storeViewModel = [[EHStorageViewModel alloc]init];
}

- (void)setupNavBar{
    //自定义返回按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 14, 23.6);
    [leftBtn setImage:[UIImage imageNamed:@"Back Arrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(NavPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)NavPop{
    [[self navigationController]popViewControllerAnimated:YES];
}

- (void)setCornerRadius{
    self.commentView.layer.borderColor = RGB(150,209,250).CGColor;
    self.commentView.layer.borderWidth = 1;
    self.commentView.layer.cornerRadius = 5;
    self.commentView.layer.masksToBounds = YES;
}

- (void)addGesture{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)setupCommentViewFrame{
    
    self.commentView.layer.borderColor = [UIColor grayColor].CGColor;
    self.commentView.layer.borderWidth = 1.0;
    self.commentView.layer.cornerRadius = 2.0;
}


- (IBAction)commitBtnClick:(id)sender {
    
    if ([EHCookieOperation setCookie]) {
        if (commentKind.length < 2) {
            [MBProgressHUD showNormalMessage:@"请选择评价级别" toView:self.view];
        }else if(_communityTextField.text.length < 1){
            [MBProgressHUD showNormalMessage:@"请选择带看小区" toView:self.view];
        }else{
            [self.agentInfo getIdStringFromDictionary];
            [_commentAgentNetViewModel submitWithText:self.commentView.text
                                                 Kind:commentKind
                                                idStr:self.agentInfo.idStr
                                            community:self.communityTextField.text
                                              superVC:self];
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

- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code{
    [modal hide:YES];
    [_storeViewModel storeCode:code];
}


#pragma mark  -- UITapGestureRecognizer
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.communityTextField resignFirstResponder];
    [self.commentView resignFirstResponder];
}


#pragma mark  -- uiTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.communityTextField resignFirstResponder];
  //  [self searchClick];
    
    return YES;
}

# pragma mark － 搜索点击
//- (void)searchClick{
//    [LBProgressHUD showHUDto:self.view animated:NO];
//    NSString *keyword = self.searchBar.text;
//    //搜索经纪人
//    NSDictionary *param =@{@"major":@"agents",
//                           @"arg":keyword};
//    [_commentAgentNetViewModel
//     searchWithURLString:searchAreaUrlStr
//                   Param:param superView:self.view
//                 success:^{
//                       EHAgentInfo *agentInfo = [_commentAgentNetViewModel.searchResultArr firstObject];
//                       [self loadResultWithAgentInfo:agentInfo];
//                       self.mask.hidden = YES;
//                          }
//                 failure:^{
//                       self.mask.hidden = NO;
//                }];
//}


- (void)loadResultWithAgentInfo:(EHAgentInfo *)agentInfo{

    self.txImageView.image = [YTNetCommand downloadImageWithImgStr:agentInfo.tx
                                               placeholderImageStr:@"Profile"
                                                         imageView:self.txImageView];
    self.name.text = agentInfo.name;
    
    if (agentInfo.position.length < 1) {
        self.position.hidden = YES;
    }else{
        self.position.text = agentInfo.position;
    }
    NSString *ratesStr = [NSString stringWithFormat:@"好评率:%.0f％",agentInfo.rates];

    self.rates.text = ratesStr;
}
#pragma mark - 取消控件的隐藏


- (IBAction)highPriseClick:(id)sender {

    self.moderateComment.selected = NO;
    self.negativeComment.selected = NO;
    self.highPraise.selected = YES;
    commentKind = @"nice";
}

- (IBAction)moderateClick:(id)sender {

    self.highPraise.selected = NO;
    self.negativeComment.selected = NO;
    self.moderateComment.selected = YES;
    commentKind = @"common";
}

- (IBAction)negativeClick:(id)sender {

    self.moderateComment.selected = NO;
    self.highPraise.selected = NO;
    self.negativeComment.selected = YES;
    commentKind = @"bad";
}
@end
