//
//  EHCommentAgentViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentViewController.h"
#import "EHAgentInfo.h"
#import <MJExtension.h>
#import "YTNetCommand.h"
#import "STModal.h"
#import "EHVerifyView.h"
#import "EHCookieOperation.h"

#import "EHChangeOffsetViewModel.h"
#import "EHCommentAgentNetViewModel.h"

@interface EHCommentAgentViewController ()<UITextFieldDelegate,UITextViewDelegate,EHVerifyViewDelegate>
{
    STModal *modal;
    EHVerifyView *verifyView;
}

@property (nonatomic,strong) EHChangeOffsetViewModel *changeOffsetViewModel;
@property (nonatomic,strong) EHCommentAgentNetViewModel *commentAgentNetViewModel;


@property (nonatomic,strong) NSMutableArray *searchResultArr;

@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UIImageView *line2;
@property (weak, nonatomic) IBOutlet UITextView *commentView;
@property (weak, nonatomic) IBOutlet UIImageView *txImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *rates;
@property (weak, nonatomic) IBOutlet UIButton *negativeComment;
@property (weak, nonatomic) IBOutlet UIButton *moderateComment;
@property (weak, nonatomic) IBOutlet UIButton *highPraise;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;

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
    self.commentView.delegate = self;
    //textview从顶开始显示
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setInitView];
    
    self.searchBar.delegate = self;
    //联网状态监测
    [YTHttpTool netCheck];

    //初始化弹窗配置
    modal = [STModal modal];
    modal.hideWhenTouchOutside = YES;
    
    [self setupNavBar];
    
    [self initViewModels];
}

- (void)initViewModels{
    _changeOffsetViewModel = [[EHChangeOffsetViewModel alloc]init];
    _commentAgentNetViewModel = [[EHCommentAgentNetViewModel alloc]init];
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

# pragma mark -初始状态，控件隐藏
- (void)setInitView{
    
    
    self.line1.hidden = YES;
    self.line2.hidden = YES;
    self.commentView.hidden = YES;
    self.txImageView.hidden = YES;
    self.name.hidden = YES;
    self.position.hidden = YES;
    self.rates.hidden = YES;
    self.negativeComment.hidden = YES;
    self.moderateComment.hidden = YES;
    self.highPraise.hidden = YES;
    self.commitBtn.hidden = YES;
    self.position.backgroundColor = RGB(234, 243, 248);

}

- (void)setCornerRadius{
    self.commentView.layer.borderColor = RGB(150,209,250).CGColor;
    self.commentView.layer.borderWidth = 1;
    self.commentView.layer.cornerRadius = 5;
    self.commentView.layer.masksToBounds = YES;

}

- (void)addGesture{
    //添加手势相应，输textfield时，点击其他区域，键盘消失
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
        }else{
            EHAgentInfo *agentInfo = [self.searchResultArr firstObject];
            [agentInfo getIdStringFromDictionary];
            [_commentAgentNetViewModel submitWithText:self.commentView.text
                                                 Kind:commentKind
                                                idStr:agentInfo.idStr
                                            superView:self.view];
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *systemDate = [NSDate date];
    NSDictionary *codeDic = @{@"date":systemDate,
                              @"code":code};
    
    [defaults setObject:codeDic forKey:@"codeDic"];
    [defaults synchronize];
    
    
}


#pragma mark  -- UITapGestureRecognizer
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.searchBar resignFirstResponder];
    [self.commentView resignFirstResponder];
}


#pragma mark  -- uiTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchBar resignFirstResponder];
    [self searchClick];
    
    return YES;
}

#pragma mark - textview 点击回车 键盘消失
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}

# pragma mark － 搜索点击
- (void)searchClick{
    [LBProgressHUD showHUDto:self.view animated:NO];
    
    NSString *keyword = self.searchBar.text;
    //搜索经纪人
    NSDictionary *param =@{@"arg":keyword};
    [self searchWithURLString:searchAgentUrlStr Param:param];
    
}
# pragma mark - 搜索方法
- (void)searchWithURLString:(NSString *)urlString Param:(NSDictionary *)param{
    
    [YTHttpTool get:urlString params:param success:^(NSURLSessionTask *task,id responseObj) {
        //json转模型
        self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObj];
        //如果找到经纪人，则取消控件的隐藏
        if([self searchStatusTest]){
            EHAgentInfo *agentInfo = [self.searchResultArr firstObject];
            [self loadResultWithAgentInfo:agentInfo];
            [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
            [self cancelHidden];
        }else{
            [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        }
    

    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
    
}
#pragma mark - 搜索结果检测
- (BOOL)searchStatusTest{
    
    if (_searchResultArr.count == 0) {
        [MBProgressHUD showSuccess:@"没有找到经纪人" toView:self.view];
        return NO;
    }else{
        [MBProgressHUD showSuccess:@"为您找到经纪人" toView:self.view];
        return YES;
    }
}

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
    NSString *ratesStr = [NSString stringWithFormat:@"好评率:%@％",agentInfo.rates];
    self.rates.text = ratesStr;
}
#pragma mark - 取消控件的隐藏
- (void)cancelHidden{
    self.line1.hidden = NO;
    self.line2.hidden = NO;
    self.commentView.hidden = NO;
    self.txImageView.hidden = NO;
    self.name.hidden = NO;
    self.position.hidden = NO;
    self.rates.hidden = NO;
    self.negativeComment.hidden = NO;
    self.moderateComment.hidden = NO;
    self.highPraise.hidden = NO;
    self.commitBtn.hidden = NO;

}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [_changeOffsetViewModel changeOffsetWithTextView:textView superView:self.view];
}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}



- (IBAction)highPriseClick:(id)sender {

    self.moderateComment.selected = NO;
    self.negativeComment.selected = NO;
    self.highPraise.selected = YES;
    commentKind = @"好评";
}

- (IBAction)moderateClick:(id)sender {

    self.highPraise.selected = NO;
    self.negativeComment.selected = NO;
    self.moderateComment.selected = YES;
    commentKind = @"中评";
}

- (IBAction)negativeClick:(id)sender {

    self.moderateComment.selected = NO;
    self.highPraise.selected = NO;
    self.negativeComment.selected = YES;
    commentKind = @"差评";
}
@end
