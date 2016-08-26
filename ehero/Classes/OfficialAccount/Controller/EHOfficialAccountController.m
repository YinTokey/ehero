//
//  EHOfficialAccountController.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHOfficialAccountController.h"
#import <WebKit/WebKit.h>

@interface EHOfficialAccountController()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation EHOfficialAccountController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *js = @"function addImgClickEvent() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) { \
    var img = imgs[i]; \
    img.onclick = function () { \
    window.location.href = 'hyb-image-preview:' + this.src; \
    }; \
    } \
    }";
    
    // 根据JS字符串初始化WKUserScript对象
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame configuration:config];
    NSURL *url = [NSURL URLWithString:self.href];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    self.webView.navigationDelegate = self;

    NSLog(@"BEGIN");
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [LBProgressHUD showHUDto:self.view animated:NO];
    NSLog(@"star load");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    NSLog(@"end load");
    
    
    
    
}



@end
