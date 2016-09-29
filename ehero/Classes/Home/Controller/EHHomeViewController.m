//
//  EHHomeViewController.m
//  ehero
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeViewController.h"
#import <SDCycleScrollView.h>

#import "AppDelegate.h"
#import "EHHomeSearchBar.h"
#import "EHSearchViewController.h"
#import "EHHomeAgentCell.h"
#import "EHSiteButton.h"
#import "EHHomePopView.h"
#import "EHOfficialAccountController.h"
#import "EHSlides.h"
#import "EHTipsRecommend.h"
#import "YTNetCommand.h"

#import "EHSiteSelectDelegate.h"
#import "EHHomeTableViewModel.h"
#import "EHHomeNetViewModel.h"

#import <MJExtension.h>
#import "UIImageView+WebCache.h"

@interface EHHomeViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate,EHHomeSearchBarDelegate>
{
    /** 图片数组*/
    NSMutableArray *sourceArr;
    NSMutableArray *titleArr;
}
- (IBAction)siteBtnClick:(UIButton *)btn;
- (IBAction)majorBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *styleBarButtonItem;

@property (weak, nonatomic) IBOutlet UIButton *majorBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *siteBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *profileBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *siteBtn;

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) EHSiteSelectDelegate *siteSelectDelegate;
@property (nonatomic,strong) EHHomeTableViewModel *homeTableViewModel;
@property (nonatomic,strong) EHHomeNetViewModel *homeNetViewModel;

//@property (nonatomic,strong) NSMutableArray *tipsRecommendArr;

@end

@implementation EHHomeViewController
{
  //  NSInteger selectedFlag;
    BOOL selectedFlag;
    NSString *major;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    major = @"sale";
  
    [self initViewModels];
    [self getSlides];

    [self setNavBar];
    
    [self getRecommentTipsInfo];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)initViewModels{
    _siteSelectDelegate = [[EHSiteSelectDelegate alloc]init];
    _siteSelectDelegate.siteButton = self.siteBtn;
    [_siteSelectDelegate readDefaults];
    
    _homeTableViewModel = [[EHHomeTableViewModel alloc]init];
    _homeTableViewModel.super = self;
    _homeTableViewModel.superVC = self;
    _homeTableViewModel.tipsRecommendArray = [NSMutableArray array];

    _homeNetViewModel = [[EHHomeNetViewModel alloc]init];

}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)setNavBar{
    self.navigationController.navigationBar.tintColor= RGB(68, 180, 244);
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    
    EHHomeSearchBar *searchbar = [[EHHomeSearchBar alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth, 30)];
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    searchbar.EHSearchBtndelegate = self;
    self.navigationItem.titleView = searchbar;
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace target : nil action : nil ];
    
    negativeSpacer.width = - 10 ;//这个数值可以根据情况自由变化
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,_profileBarButtonItem,_siteBarButtonItem];

    self.navigationItem.rightBarButtonItems = @[negativeSpacer,_styleBarButtonItem];
    
}

- (void)setupHeaderView{

    _cycleScrollView.autoScrollTimeInterval = 3.5;

   _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.tableView.frame.size.width - 10, ScreenHeight * 0.3)
                                       delegate:self
                               placeholderImage:[UIImage imageNamed:@"home_placeholder"]];
    _cycleScrollView.imageURLStringsGroup = sourceArr;
    _cycleScrollView.titlesGroup = titleArr;
    _cycleScrollView.showPageControl = NO;
    self.tableView.tableHeaderView = _cycleScrollView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    EHOfficialAccountController *officialAccountVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"OfficialAccountController"];
    EHSlides *slide = _homeNetViewModel.slidesArray[index];
    officialAccountVC.slide = slide;

    [self.navigationController pushViewController:officialAccountVC animated:YES];
    
}

- (void)getSlides{
    sourceArr = [NSMutableArray array];
    titleArr = [NSMutableArray array];
    [_homeNetViewModel getSlidesWithSourceArr:sourceArr titleArr:titleArr superView:self.view success:^{
        [self setupHeaderView];
    } failure:^{
       // [MBProgressHUD showError:@"加载失败"];
        [self setupHeaderView];
    }];
}

- (IBAction)siteBtnClick:(UIButton *)btn {
   //暂时禁止弹窗
  //  [self setupPopView];
}

- (IBAction)majorBtnClick:(id)sender {
    selectedFlag =! selectedFlag;
    self.majorBtn.selected = YES;
    if (selectedFlag) {
        self.majorBtn.selected = YES;
        major = @"rent";
      
    }else{
        self.majorBtn.selected = NO;
        major = @"sale";
 
    }
  
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    EHSearchViewController *searchVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"SearchViewController"];
    searchVC.major = major;
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 设置左上角地点弹窗
- (void)setupPopView{
    
    EHHomePopView *homePopView = [EHHomePopView initPopView:_siteBtn SuperView:self.view];
    homePopView.delegate = _siteSelectDelegate;
    [homePopView popView];
    
}

- (void)getRecommentTipsInfo{
    _homeTableViewModel.imageUrlStrArray = [NSMutableArray array];
    [YTHttpTool get:TipsRecommendUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
        _homeTableViewModel.tipsRecommendArray = [EHTipsRecommend mj_objectArrayWithKeyValuesArray:responseObj];
        for (EHTipsRecommend *tip in _homeTableViewModel.tipsRecommendArray) {
            NSString *realUrlStr = [tip.thumb stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            [_homeTableViewModel.imageUrlStrArray addObject:realUrlStr];
        }
        //请求成功后，再设置数据源
        self.tableView.dataSource = _homeTableViewModel;
        self.tableView.delegate = _homeTableViewModel;
        [MBProgressHUD hideHUDForView:self.view];
        
    } failure:^(NSError *error) {
        //网络请求失败，空数据
        EHTipsRecommend *tip = [[EHTipsRecommend alloc]init];
        tip.name = @"";
        for (NSInteger i = 0; i < 5; i ++) {
            [_homeTableViewModel.tipsRecommendArray addObject:tip];
            [_homeTableViewModel.imageUrlStrArray addObject:@"about:cehome"];
        }
        //请求成功后，再设置数据源
        self.tableView.dataSource = _homeTableViewModel;
        self.tableView.delegate = _homeTableViewModel;
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"请求失败,请重启应用"];
        NSLog(@"failure");
    }];
}

#pragma mark - 搜索栏代理
- (void)searchBtnClick{
    EHSearchViewController *searchVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"SearchViewController"];
    searchVC.major = major;
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
