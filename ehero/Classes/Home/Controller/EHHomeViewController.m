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
#import "SDAutoLayout.h"
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

#import "EHTipsViewCell.h"

@interface EHHomeViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate>
{
    /** 图片数组*/
    NSMutableArray *sourceArr;
    NSMutableArray *titleArr;
    //锦囊对象
    NSMutableArray *tipsRecommendArr;
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
    [YTHttpTool netCheck];
    [self setNavBar];
    
//    NSIndexPath *tipsCellIndex = [NSIndexPath indexPathForRow:0 inSection:1];
//    EHTipsViewCell *TipsCell = [self.tableView cellForRowAtIndexPath:tipsCellIndex];
//    
//    [RACObserve(_homeTableViewModel, netImageFlag)subscribeNext:^(id x) {
//        [TipsCell.pageFlowView reloadData];
//        NSLog(@"reload");
//    }];

}

- (void)initViewModels{
    _siteSelectDelegate = [[EHSiteSelectDelegate alloc]init];
    _siteSelectDelegate.siteButton = self.siteBtn;
    [_siteSelectDelegate readDefaults];
    
    _homeTableViewModel = [[EHHomeTableViewModel alloc]init];
    _homeTableViewModel.super = self;
    _homeTableViewModel.superVC = self;
    _homeTableViewModel.imageArray = [NSMutableArray array];
    //[_homeTableViewModel getTipsInfo];
    UIImage *image0 = [UIImage imageNamed:@"community1"];
    [_homeTableViewModel.imageArray  addObject:image0];
    [_homeTableViewModel getTipsInfo];
    
    _homeNetViewModel = [[EHHomeNetViewModel alloc]init];

    self.tableView.dataSource = _homeTableViewModel;
    self.tableView.delegate = _homeTableViewModel;
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
    
    [self setupPopView];
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

//- (void)getTipsInfo{
//    UIImageView *imageView = [[UIImageView alloc]init];
//    [YTHttpTool get:TipsRecommendUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
//        tipsRecommendArr = [EHTipsRecommend mj_objectArrayWithKeyValuesArray:responseObj];
//        
//        for (EHTipsRecommend *tipsR in tipsRecommendArr) {
//            [_homeTableViewModel.imageArray addObject:[YTNetCommand downloadImageWithImgStr:tipsR.thumb placeholderImageStr:@"home_placeholder" imageView:imageView]];
//        }
//        NSLog(@"tips %d",_homeTableViewModel.imageArray.count);
//    } failure:^(NSError *error) {
//        NSLog(@"failure");
//    }];
//}
@end
