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

#import "EHOfficialViewModel.h"


@interface EHOfficialAccountController()<WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) EHOfficialViewModel *officialViewModel;
@property (nonatomic,strong) EHSocialShareViewModel *socialViewModel;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)collectBtnClick:(id)sender;




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
    [YTHttpTool netCheck];
    self.title = self.slide.title;
    [self isCollected];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    
    [self initViewModels];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame];

    NSURL  *url = [NSURL URLWithString:self.slide.href];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    self.webView.navigationDelegate = _officialViewModel;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];

    titleArray = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈",@"QQ空间",@"QQ好友", nil];
    picArray = [NSMutableArray arrayWithObjects:@"share_wechat",@"share_timeline",@"share_qzone",@"share_qq",nil];

}

- (void)initViewModels{
    _socialViewModel = [[EHSocialShareViewModel alloc]init];
    _officialViewModel = [[EHOfficialViewModel alloc]init];
    _officialViewModel.superVC = self;

}


- (IBAction)shareBtnClick:(id)sender {
    //分享界面弹窗
    ShareView *share = [[ShareView alloc]initWithTitleArray:titleArray picArray:picArray];
    [share showShareView];
    _socialViewModel.shareToQzoneFlag = YES;
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
