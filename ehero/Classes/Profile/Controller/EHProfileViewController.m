//
//  EHProfileViewController.m
//  ehero
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHProfileViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD+YT.h"
#import "EHCollectedAgentsViewController.h"
#import "EHSkimedAgentsViewController.h"
#import <MBProgressHUD.h>
#import "EHCollectedArticleViewController.h"
#import "EHMailViewModel.h"
#import "EHCollectedTipsController.h"



@interface EHProfileViewController ()
- (IBAction)skimedAgentsClick:(id)sender;
- (IBAction)skimedHouseClick:(id)sender;
- (IBAction)tipsClick:(id)sender;
- (IBAction)agentsClick:(id)sender;
- (IBAction)articleClick:(id)sender;
- (IBAction)houseClick:(id)sender;
- (IBAction)contactClick:(id)sender;
- (IBAction)aboutClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tips;
@property (weak, nonatomic) IBOutlet UIButton *agents;
@property (weak, nonatomic) IBOutlet UIButton *house;
@property (weak, nonatomic) IBOutlet UIButton *article;
@property (weak, nonatomic) IBOutlet UIButton *contact;
@property (weak, nonatomic) IBOutlet UIButton *about;
@property (weak, nonatomic) IBOutlet UIButton *recentAgents;
@property (weak, nonatomic) IBOutlet UIButton *recentHouses;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic,strong)EHMailViewModel *mailViewModel;

@end

@implementation EHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);
    [self initViewModels];
    [self setupButtonsTextAlignment];

  //  [self fitScreen];
    
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];

    
}

- (void)setupButtonsTextAlignment{
    self.tips.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.tips.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.agents.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.agents.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.house.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.house.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.contact.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contact.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.about.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.about.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.article.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.article.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

- (void)fitScreen{

     self.recentAgents.sd_layout
    .widthRatioToView(self.view,0.468)
    .leftSpaceToView(self.view,ScreenWidth * 0.025)
    .heightRatioToView(self.view,0.102);

     self.recentHouses.sd_layout
    .widthRatioToView(self.view,0.468)
    .rightSpaceToView(self.view,ScreenWidth * 0.025)
    .heightRatioToView(self.view,0.102);
    

    
}

- (void)initViewModels{
    _mailViewModel = [[EHMailViewModel alloc]init];
    _mailViewModel.superVC = self;
}

- (IBAction)skimedAgentsClick:(id)sender {

    EHCollectedAgentsViewController *collectedAgentsVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"SkimedAgentsViewController"];
    [self.navigationController pushViewController:collectedAgentsVC animated:YES];
    
}

- (IBAction)skimedHouseClick:(id)sender {
}

- (IBAction)tipsClick:(id)sender {
    EHCollectedTipsController  *collectedTipsVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"CollectedTipsController"];
    [self.navigationController pushViewController:collectedTipsVC animated:YES];
}

- (IBAction)agentsClick:(id)sender {
    EHCollectedAgentsViewController *collectedAgentsVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"CollectedAgentsViewController"];
    [self.navigationController pushViewController:collectedAgentsVC animated:YES];
}

- (IBAction)articleClick:(id)sender {
    EHCollectedArticleViewController *collectedArticleVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"CollectedArticleViewController"];
    [self.navigationController pushViewController:collectedArticleVC animated:YES];
    
}

- (IBAction)houseClick:(id)sender {
    
}

- (IBAction)contactClick:(id)sender {
    [self sendEmail];
}

- (IBAction)aboutClick:(id)sender {
}

# pragma mark - 邮件推送
-(void)sendEmail{
    if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
        [_mailViewModel sendEmailAction]; // 调用发送邮件的代码
    }else{
        [MBProgressHUD showNormalMessage:@"请设置邮箱帐号" toView:self.view];
    }
}

@end
