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

#import "EHSiteSelectDelegate.h"
#import "EHHomeTableViewModel.h"


@interface EHHomeViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate>
{
    /** 图片数组*/
    NSMutableArray *sourceArr;
    
}
- (IBAction)styleSel:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *styleBarButtonItem;

@property (weak, nonatomic) IBOutlet UIButton *styleBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *siteBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *profileBarButtonItem;

- (IBAction)siteBtnClick:(UIButton *)btn;
@property (weak, nonatomic) IBOutlet UIButton *siteBtn;


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

    [self setNavBar];
    [self setupHeaderView];
    [self initViewModels];
    [YTHttpTool netCheck];
    
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
    sourceArr = [NSMutableArray arrayWithObjects:@"img_00",@"img_01",@"img_02", nil];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.tableView.frame.size.width - 10, ScreenHeight * 0.3) imageNamesGroup:sourceArr];
    _cycleScrollView.autoScrollTimeInterval = 3.5;

    self.tableView.tableHeaderView = _cycleScrollView;
    
    _cycleScrollView.delegate = self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%d",index);
    EHOfficialAccountController *officialAccountVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"OfficialAccountController"];
    [self.navigationController pushViewController:officialAccountVC animated:YES];
    
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
