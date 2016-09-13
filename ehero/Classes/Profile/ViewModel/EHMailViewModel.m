//
//  EHMailViewModel.m
//  ehero
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHMailViewModel.h"

@implementation EHMailViewModel


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
    [_superVC presentViewController:mailCompose animated:YES completion:nil];
    //[MBProgressHUD showNormalMessage:@"Set your email!" showDetailText:nil  toView:self.view];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑、
            
            [MBProgressHUD showNormalMessage:@"取消编辑" toView:_superVC.view];
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            [MBProgressHUD showNormalMessage:@"保存邮件" toView:_superVC.view];
            break;
        case MFMailComposeResultSent: // 用户点击发送
            [MBProgressHUD showSuccess:@"发送成功" toView:_superVC.view];
            //  NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            //  NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            [MBProgressHUD showError:@"发送失败"];
            break;
    }
    
    // 关闭邮件发送视图
    [_superVC dismissViewControllerAnimated:YES completion:nil];
}


@end
