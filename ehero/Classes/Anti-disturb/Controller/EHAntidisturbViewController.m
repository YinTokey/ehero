//
//  EHAntidisturbViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAntidisturbViewController.h"
#import <WebKit/WebKit.h>
@interface EHAntidisturbViewController ()<WKNavigationDelegate>

@property (nonatomic,strong)WKWebView *webView;
@end

@implementation EHAntidisturbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self webViewLoad];
}

- (void)webViewLoad{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webView.scrollView.bounces = NO;
    self.webView = webView;
    [self.view addSubview:_webView];
    self.webView.navigationDelegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://ehero.cc/helper"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [LBProgressHUD showHUDto:self.view animated:NO];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
}
@end
