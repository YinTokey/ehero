//
//  EHGuideViewController.m
//  ehero
//
//  Created by Mac on 16/7/9.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHGuideViewController.h"


@interface EHGuideViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *wb;






@end


@implementation EHGuideViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"图解HTTP" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
  //  [self.wb loadRequest:request];
    
//   self.wb.translatesAutoresizingMaskIntoConstraints = NO;
//   // self.wb.hidden = YES;
//    
//    
//    NSString *path=[[NSBundle mainBundle]pathForResource:@"图解HTTP" ofType:@"pdf"];
//    //获取内容
//    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
//    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",string);
//    self.wb.delegate = self;
//    self.wb.scalesPageToFit = YES;
//    
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [self.wb loadRequest:request];
   // [self loadPDF];
}

- (void)loadPDF{
//      WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
//    
//    [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"图解HTTP" ofType:@"pdf"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    [self.wb loadData:data MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:nil];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    [webView loadRequest:request];
//    
//    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *path = [NSString stringWithFormat:@"%@/Socket.pdf",cacheDir];
//    
//    [self.wb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
//    [self.view addSubview:webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"图解HTTP.pdf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
  //  NSLog(@"%@", [self mimeType:url]);
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
  //  [self.wb loadData:data MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:url];
    NSURL *neturl = [NSURL URLWithString:@"www.baidu.com"];
    NSURLRequest *re = [NSURLRequest requestWithURL:neturl];
    [self.wb loadRequest:re];
}

@end
