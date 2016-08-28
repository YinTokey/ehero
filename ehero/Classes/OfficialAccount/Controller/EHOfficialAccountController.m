//
//  EHOfficialAccountController.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHOfficialAccountController.h"
#import <WebKit/WebKit.h>
#import "ShareView.h"
#import "EHSocialShareViewModel.h"
#import <MWPhotoBrowser.h>

#define jsClick  @"function addImgClickEvent() { \
                var imgs = document.getElementsByTagName('img'); \
                for (var i = 0; i < imgs.length; ++i) { \
                    var img = imgs[i]; \
                    img.onclick = function () { \
                        window.location.href = 'hyb-image-preview:' + this.src; \
                        }; \
                    } \
                }"


@interface EHOfficialAccountController()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (nonatomic,strong) EHSocialShareViewModel *socialViewModel;

@end

@implementation EHOfficialAccountController
{
    BOOL starLoadFlag;
    BOOL selectedFlag;
    NSMutableArray *titleArray;
    NSMutableArray *picArray;
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = self.slide.title;
    
    [self isCollected];
    
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:self.slide.href];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    self.webView.navigationDelegate = self;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];

    titleArray = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈",@"微博",@"QQ好友", nil];
    picArray = [NSMutableArray arrayWithObjects:@"share_wechat",@"share_timeline",@"share_weibo",@"share_qq",nil];
    [self initViewModels];
    
    
}

- (void)initViewModels{
    _socialViewModel = [[EHSocialShareViewModel alloc]init];

}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [LBProgressHUD showHUDto:self.view animated:NO];
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
    [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    NSLog(@"end load");
    //注入js代码
    [self.webView evaluateJavaScript:jsClick completionHandler:^(id Result , NSError * _Nullable error) {

     }];
    //执行js
    [self.webView evaluateJavaScript:@"addImgClickEvent();" completionHandler:^(id Result, NSError * error) {
        NSLog(@"c:%@",Result);
        NSLog(@"err %@",error);
    }];
    
}

- (void)gotoPhotoBrowser:(NSString *)photoUrlString{
    
     NSURL *photoUrl = [NSURL URLWithString:photoUrlString];
     NSArray *photoArray = @[[MWPhoto photoWithURL:photoUrl]];
     MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photoArray];
     [self.navigationController pushViewController:browser animated:YES];
    
    
}


- (IBAction)shareBtnClick:(id)sender {
    //分享界面弹窗
    ShareView *share = [[ShareView alloc]initWithTitleArray:titleArray picArray:picArray];
    [share showShareView];
    [share currentIndexWasSelected:^(NSInteger index) {
        _socialViewModel.desc = @" ";
        _socialViewModel.title = self.slide.title;
        _socialViewModel.link = self.slide.href;
        [_socialViewModel shareWithIndex:index];

    }];
}
- (IBAction)collectBtnClick:(id)sender {
    selectedFlag = !selectedFlag;
    if (selectedFlag) {
        
        self.collectBtn.selected = YES;
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        [self.slide save];
                
    }else{
        
        self.collectBtn.selected = NO;
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.view];
        [self.slide deleteObject];
    }
}

- (void)isCollected{
    NSString *sqlForName = [NSString stringWithFormat:@" WHERE title = '%@' ",self.slide.title];
    EHSlides *slideExisted = [EHSlides findFirstByCriteria:sqlForName];
    
    if (slideExisted == nil) {
        selectedFlag = NO;
        self.collectBtn.selected = NO;
    }else{
        selectedFlag = YES;
        self.collectBtn.selected = YES;
    }
    
}
@end
