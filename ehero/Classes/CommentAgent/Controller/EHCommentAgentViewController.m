//
//  EHCommentAgentViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentAgentViewController.h"
#import "CWStarRateView.h"
@interface EHCommentAgentViewController ()<UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) CWStarRateView *starRateView;
@property (weak, nonatomic) IBOutlet UITextView *commentView;
@property (weak, nonatomic) IBOutlet UITextField *agentName;

- (IBAction)commitBtnClick:(id)sender;
@end

@implementation EHCommentAgentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupStarRateView];
    [self setupCommentViewFrame];
    
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    self.agentName.delegate = self;
    self.commentView.delegate = self;
    
}


- (void)setupCommentViewFrame{
    
    self.commentView.layer.borderColor = [UIColor grayColor].CGColor;
    self.commentView.layer.borderWidth = 1.0;
    self.commentView.layer.cornerRadius = 2.0;
}

- (void)setupStarRateView{
    self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(10, 120, 300, 40) numberOfStars:5];
    self.starRateView.scorePercent = 0.3;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    [self.view addSubview:self.starRateView];
}

- (IBAction)commitBtnClick:(id)sender {
    NSLog(@"提交");
}

#pragma mark  -- UITapGestureRecognizer
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.agentName resignFirstResponder];
    [self.commentView resignFirstResponder];
}


#pragma mark  -- uiTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - textview 点击回车 键盘消失
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    CGRect frame = textView.frame;
    
    int offset = frame.origin.y + 0 - (self.view.frame.size.height - 263.0);//iPhone键盘高度216，iPad的为352,这里设成263更方便，并且考虑到搜狗的键盘比系统的键盘高一点
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:0.5f];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    
    if(offset < -15)
        
    self.view.frame = CGRectMake(0.0f, offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];


}

//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}



@end
