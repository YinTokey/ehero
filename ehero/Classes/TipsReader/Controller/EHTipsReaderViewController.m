//
//  EHTipsReaderViewController.m
//  ehero
//
//  Created by Mac on 16/9/2.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsReaderViewController.h"
#import <WebKit/WebKit.h>
#import "ShareView.h"
#import "EHSocialShareViewModel.h"

#import "EHOfficialViewModel.h"
@interface EHTipsReaderViewController ()

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) EHOfficialViewModel *officialViewModel;
@property (nonatomic,strong) EHSocialShareViewModel *socialViewModel;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
- (IBAction)collectBtnClick:(id)sender;
- (IBAction)shareBtnClick:(id)sender;


@end

@implementation EHTipsReaderViewController
{
    BOOL starLoadFlag;
    BOOL selectedFlag;
    NSMutableArray *titleArray;
    NSMutableArray *picArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [YTHttpTool netCheck];
    self.title = self.tipsRecomnend.name;
    [self initViewModels];
    
    _webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    //中文url 要转义
    self.tipsRecomnend.route = [self.tipsRecomnend.route stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSURL  *url = [NSURL URLWithString:self.tipsRecomnend.route];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView.navigationDelegate = _officialViewModel;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    titleArray = [NSMutableArray arrayWithObjects:@"微信好友",@"朋友圈",@"微博",@"QQ好友", nil];
    picArray = [NSMutableArray arrayWithObjects:@"share_wechat",@"share_timeline",@"share_weibo",@"share_qq",nil];
}

- (void)initViewModels{
    _socialViewModel = [[EHSocialShareViewModel alloc]init];
    _officialViewModel = [[EHOfficialViewModel alloc]init];
    _officialViewModel.superVC = self;
}

- (IBAction)collectBtnClick:(id)sender {
    selectedFlag = !selectedFlag;
    if (selectedFlag) {
        
        self.collectBtn.selected = YES;
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        [self.tipsRecomnend save];
        
    }else{
        
        self.collectBtn.selected = NO;
        [MBProgressHUD showSuccess:@"取消收藏" toView:self.view];
        [self.tipsRecomnend deleteObject];
    }
}

- (IBAction)shareBtnClick:(id)sender {
    //分享界面弹窗
    ShareView *share = [[ShareView alloc]initWithTitleArray:titleArray picArray:picArray];
    [share showShareView];
    _socialViewModel.shareToQzoneFlag = NO;
    [share currentIndexWasSelected:^(NSInteger index) {
        _socialViewModel.desc = @" ";
        NSString *title = [NSString stringWithFormat:@"分享租房锦囊之 %@",self.tipsRecomnend.name];
        _socialViewModel.title = title;
        _socialViewModel.link = self.tipsRecomnend.route;
        [_socialViewModel shareWithIndex:index];
        
    }];
    
}
@end
