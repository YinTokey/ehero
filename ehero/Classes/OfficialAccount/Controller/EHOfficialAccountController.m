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
    [LBProgressHUD showHUDto:self.view animated:NO];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:self.href];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    self.webView.navigationDelegate = self;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];

    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
    NSLog(@"star load");

}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([navigationAction.request.URL.scheme hasPrefix:@"hyb-image-preview"]) {
        // 获取原始图片的完整URL
        NSString *src = [navigationAction.request.URL.absoluteString stringByReplacingOccurrencesOfString:@"hyb-image-preview:" withString:@""];
        if (src.length > 0) {
  
            NSLog(@"所点击的HTML中的img标签的图片的URL为：%@", src);
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    NSLog(@"end load");
    //注入js代码
    [self.webView evaluateJavaScript:@"function addImgClickEvent() { \
     var imgs = document.getElementsByTagName('img'); \
     for (var i = 0; i < imgs.length; ++i) { \
     var img = imgs[i]; \
     img.onclick = function () { \
     window.location.href = 'hyb-image-preview:' + this.src; \
     }; \
     } \
     }" completionHandler:^(id Result , NSError * _Nullable error) {

     }];
    //执行js
    [self.webView evaluateJavaScript:@"addImgClickEvent();" completionHandler:^(id Result, NSError * error) {
        NSLog(@"c:%@",Result);
        NSLog(@"err %@",error);
    }];
    
}




@end
