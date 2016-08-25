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
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"https://mp.weixin.qq.com/s?__biz=MzIzNTQ1MzM5Nw==&mid=2247483908&idx=1&sn=53879479d7779765f7085177734191dc&scene=0&key=cf237d7ae24775e88681f22656b282cfd2492f3ce4321043e8ae3fbbf30bd9f8bcae329928d04d0d229c7ea9a4beebdc&ascene=0&uin=MjgzMjkxOTk2NA%3D%3D&devicetype=iMac+MacBook8%2C1+OSX+OSX+10.11.2+build(15C50)&version=11020201&pass_ticket=DWiENvNqwsyB4fOern0MHiYgGOpA3yoYDpTnZZZJmSbWFthFaaCRLIgULOv9zh%2Fk"];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}


@end
