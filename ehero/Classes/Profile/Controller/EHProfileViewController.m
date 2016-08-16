//
//  EHProfileViewController.m
//  ehero
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHProfileViewController.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "MBProgressHUD+YT.h"
#import "SDAutoLayout.h"
#import "EHCollectedAgentsViewController.h"
#import "EHSkimedAgentsViewController.h"
#import <MBProgressHUD.h>

@interface EHProfileViewController ()<MFMailComposeViewControllerDelegate>
- (IBAction)skimedAgentsClick:(id)sender;
- (IBAction)skimedHouseClick:(id)sender;
- (IBAction)tipsClick:(id)sender;
- (IBAction)agentsClick:(id)sender;
- (IBAction)houseClick:(id)sender;
- (IBAction)contactClick:(id)sender;
- (IBAction)aboutClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tips;
@property (weak, nonatomic) IBOutlet UIButton *agents;
@property (weak, nonatomic) IBOutlet UIButton *house;
@property (weak, nonatomic) IBOutlet UIButton *contact;
@property (weak, nonatomic) IBOutlet UIButton *about;
@property (weak, nonatomic) IBOutlet UIButton *recentAgents;
@property (weak, nonatomic) IBOutlet UIButton *recentHouses;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic,strong)UIButton *ttt;

@end

@implementation EHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);

    [self setupButtonsTextAlignment];
    NSLog(@"%f",self.view.frame.size.height);
    NSLog(@"%f",self.view.frame.size.width);
    
    NSLog(@"screen %f",[UIScreen mainScreen].bounds.size.height);
    
    [self fitScreen];
    
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    
//    UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(150, 150, 50, 50)];
//    [self.view addSubview:bt];
//    bt.backgroundColor = [UIColor redColor];
//    self.ttt = bt;
    
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


- (IBAction)skimedAgentsClick:(id)sender {

    EHCollectedAgentsViewController *collectedAgentsVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"SkimedAgentsViewController"];
    [self.navigationController pushViewController:collectedAgentsVC animated:YES];
    
}

- (IBAction)skimedHouseClick:(id)sender {
}

- (IBAction)tipsClick:(id)sender {
}

- (IBAction)agentsClick:(id)sender {
    EHCollectedAgentsViewController *collectedAgentsVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"CollectedAgentsViewController"];
    [self.navigationController pushViewController:collectedAgentsVC animated:YES];
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
        [self sendEmailAction]; // 调用发送邮件的代码
    }else{
        [self.view makeToast:@"设置邮箱账号" duration:1.0 position:CSToastPositionCenter];
    }
}

# pragma mark - MFMailComposeViewControllerDelegate的代理方法：
- (void)sendEmailAction
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"易房好介反馈"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"ehero.cc@qq.com"]];
    // 设置抄送人
    //  [mailCompose setCcRecipients:@[@"YinjChen@163.com"]];
    // 设置密抄送
    //  [mailCompose setBccRecipients:@[@"348232068@qq.com"]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    //	[mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
    /**
     *  添加附件
     */
    //    UIImage *image = [UIImage imageNamed:@"image"];
    //    NSData *imageData = UIImagePNGRepresentation(image);
    //    [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"custom.png"];
    //    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    //    NSData *pdf = [NSData dataWithContentsOfFile:file];
    //    [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"7天精通IOS233333"];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
    //[MBProgressHUD showNormalMessage:@"Set your email!" showDetailText:nil  toView:self.view];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑、
            [self.view makeToast:@"取消编辑" duration:1.0 position:CSToastPositionCenter];
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            [self.view makeToast:@"保存邮件" duration:1.0 position:CSToastPositionCenter];
            break;
        case MFMailComposeResultSent: // 用户点击发送
            [self.view makeToast:@"发送成功" duration:1.0 position:CSToastPositionCenter];
            //  NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            //  NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            [self.view makeToast:@"发送失败" duration:1.0 position:CSToastPositionCenter];
            break;
    }
    
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
