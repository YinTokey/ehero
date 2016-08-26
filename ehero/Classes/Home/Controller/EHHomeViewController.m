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
#import "YTNetCommand.h"

#import "EHSiteSelectDelegate.h"
#import "EHHomeTableViewModel.h"

#import <MJExtension.h>

@interface EHHomeViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate>
{
    /** 图片数组*/
    NSMutableArray *sourceArr;
    NSMutableArray *titleArr;
}
- (IBAction)siteBtnClick:(UIButton *)btn;
- (IBAction)styleSel:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *styleBarButtonItem;

@property (weak, nonatomic) IBOutlet UIButton *styleBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *siteBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *profileBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *siteBtn;
@property (nonatomic,strong) NSMutableArray *slidesArray;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) EHSiteSelectDelegate *siteSelectDelegate;
@property (nonatomic,strong) EHHomeTableViewModel *homeTableViewModel;


@end

@implementation EHHomeViewController
{
    NSInteger selectedFlag;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getSlides];
    [self setNavBar];

    [self initViewModels];
    [YTHttpTool netCheck];
  
    //[self setupHeaderView];
}

- (void)initViewModels{
    _siteSelectDelegate = [[EHSiteSelectDelegate alloc]init];
    _siteSelectDelegate.siteButton = self.siteBtn;
    [_siteSelectDelegate readDefaults];
    
    _homeTableViewModel = [[EHHomeTableViewModel alloc]init];
    _homeTableViewModel.super = self;
    _homeTableViewModel.superVC = self;

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
    NSLog(@"%d",index);
    
    EHOfficialAccountController *officialAccountVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"OfficialAccountController"];
    EHSlides *slide = _slidesArray[index];
    
    officialAccountVC.href = slide.href;
    officialAccountVC.title = slide.title;
    [self.navigationController pushViewController:officialAccountVC animated:YES];
    
}

- (void)getSlides{
    sourceArr = [NSMutableArray array];
    titleArr = [NSMutableArray array];
    
    [MBProgressHUD showMessage:@"正在加载图片" toView:self.view];
    [YTHttpTool get:slidesUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
        [MBProgressHUD hideHUDForView:self.view];
        //数据处理
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        _slidesArray = [EHSlides mj_objectArrayWithKeyValuesArray:responseArray];
        NSLog(@"%d",_slidesArray.count);
        for (EHSlides *slide in _slidesArray) {
            [sourceArr addObject:slide.image];
            [titleArr addObject:slide.title];
        }
        [self setupHeaderView];
    } failure:^(NSError *error) {
        NSLog(@"failed");
    }];
}

- (IBAction)siteBtnClick:(UIButton *)btn {
    
    [self setupPopView];
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
        EHSearchViewController *searchVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - 设置左上角地点弹窗
- (void)setupPopView{
    EHHomePopView *homePopView = [EHHomePopView initPopView:_siteBtn SuperView:self.view];
    homePopView.delegate = _siteSelectDelegate;
    [homePopView popView];
}

- (IBAction)styleSel:(id)sender {
    selectedFlag ++;
    self.styleBtn.selected  = YES;
    if (selectedFlag %2 == 1) {
        self.styleBtn.selected  = YES;
    }else{
        self.styleBtn.selected = NO;
    }
}
@end
