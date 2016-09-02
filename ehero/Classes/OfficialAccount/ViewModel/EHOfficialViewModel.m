//
//  EHOfficialViewModel.m
//  ehero
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHOfficialViewModel.h"
#import <MWPhotoBrowser.h>


@implementation EHOfficialViewModel
{
    BOOL starLoadFlag;
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [LBProgressHUD showHUDto:_superVC.view animated:NO];
    NSLog(@"star load");
    starLoadFlag = YES;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    if ([navigationAction.request.URL.scheme hasPrefix:@"hyb-image-preview"]) {
        // 获取原始图片的完整URL
        NSString *src = [navigationAction.request.URL.absoluteString stringByReplacingOccurrencesOfString:@"hyb-image-preview:" withString:@""];
        if (src.length > 0) {
            NSLog(@"所点击的HTML中的img标签的图片的URL为：%@", src);
            
            [self gotoPhotoBrowser:src];
        }
    }
    
    if (starLoadFlag) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LBProgressHUD hideAllHUDsForView:_superVC.view animated:NO];
    NSLog(@"end load");
    //注入js代码
    [webView evaluateJavaScript:jsClick completionHandler:^(id Result , NSError * _Nullable error) {
        
    }];
    //执行js
    [webView evaluateJavaScript:@"addImgClickEvent();" completionHandler:^(id Result, NSError * error) {
        NSLog(@"c:%@",Result);
        NSLog(@"err %@",error);
    }];
    
}

- (void)gotoPhotoBrowser:(NSString *)photoUrlString{
    
    NSURL *photoUrl = [NSURL URLWithString:photoUrlString];
    NSArray *photoArray = @[[MWPhoto photoWithURL:photoUrl]];
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photoArray];
    [self.superVC.navigationController pushViewController:browser animated:YES];
    
}

@end
