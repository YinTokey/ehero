//
//  EHTipsViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewController.h"
#import "DCNavTabBarController.h"

#import "EHHaidianViewController.h"
#import "EHChangpingViewController.h"
#import "EHChaoyangViewController.h"
#import "EHDongchengViewController.h"
#import "EHXichengViewController.h"
#import "EHFengtaiViewController.h"
#import "EHTipsRecommend.h"
#import <MJExtension.h>

@interface EHTipsViewController ()

@property (nonatomic,strong) NSMutableArray *allTipsArray;

@property (nonatomic,strong) EHHaidianViewController *HaidianVC;
@property (nonatomic,strong) EHChangpingViewController *ChangpingVC;
@property (nonatomic,strong) EHChaoyangViewController *ChaoyangVC;
@property (nonatomic,strong) EHDongchengViewController *DongchengVC;
@property (nonatomic,strong) EHXichengViewController *XichengVC;
@property (nonatomic,strong) EHFengtaiViewController *FengtaiVC;



@end

@implementation EHTipsViewController

- (NSMutableArray * )allTipsArray{
    if (_allTipsArray == nil) {
        _allTipsArray = [NSMutableArray array];
    }
    return _allTipsArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBottomLine];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    [self setupChildController];
    [self getAllTips];

    
}

- (void)getAllTips{
    [LBProgressHUD showHUDto:self.view animated:NO];
    [YTHttpTool get:allTipsUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
        self.allTipsArray = [EHTipsRecommend mj_objectArrayWithKeyValuesArray:responseObj];
        [self assignTips];
      //  [self setupChildController];
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    } failure:^(NSError *error) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [MBProgressHUD showError:@"请求失败"];
    }];

}

- (void)assignTips{
    //分配锦囊
    for (EHTipsRecommend *tip in self.allTipsArray) {
        if ([tip.district isEqualToString:_HaidianVC.title]) {
            [self.HaidianVC.tipsRecommendArray addObject:tip];
            [self.HaidianVC.collectionView reloadData];
        }
        if ([tip.district isEqualToString:_ChaoyangVC.title]) {
            [self.ChaoyangVC.tipsRecommendArray addObject:tip];
            [self.ChaoyangVC.collectionView reloadData];
        }
        if ([tip.district isEqualToString:_DongchengVC.title]) {
            [self.DongchengVC.tipsRecommendArray addObject:tip];
            [self.DongchengVC.collectionView reloadData];
        }
        if ([tip.district isEqualToString:_XichengVC.title]) {
            [self.XichengVC.tipsRecommendArray addObject:tip];
            [self.XichengVC.collectionView reloadData];
        }
        if ([tip.district isEqualToString:_ChangpingVC.title]) {
            [self.ChangpingVC.tipsRecommendArray addObject:tip];
            [self.ChangpingVC.collectionView reloadData];
        }
        if ([tip.district isEqualToString:_FengtaiVC.title]) {
            [self.FengtaiVC.tipsRecommendArray addObject:tip];
            [self.FengtaiVC.collectionView reloadData];
        }
        
    }

}



- (void)setupChildController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Tips" bundle:[NSBundle mainBundle]];
    
    self.HaidianVC = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    self.HaidianVC.title = @"海淀";
    self.ChaoyangVC = [sb instantiateViewControllerWithIdentifier:@"ChaoyangViewController"];
    self.ChaoyangVC.title = @"朝阳";
    self.DongchengVC = [sb instantiateViewControllerWithIdentifier:@"DongchengViewController"];
    self.DongchengVC.title = @"东城";
    self.XichengVC = [sb instantiateViewControllerWithIdentifier:@"XichengViewController"];
    self.XichengVC.title = @"西城";
    self.ChangpingVC = [sb instantiateViewControllerWithIdentifier:@"ChangpingViewController"];
    self.ChangpingVC.title = @"昌平";
    self.FengtaiVC = [sb instantiateViewControllerWithIdentifier:@"FengtaiViewController"];
    self.FengtaiVC.title = @"丰台";

    
    //初始化数组
    _HaidianVC.tipsRecommendArray = [NSMutableArray array];
    _DongchengVC.tipsRecommendArray = [NSMutableArray array];
    _XichengVC.tipsRecommendArray = [NSMutableArray array];
    _ChaoyangVC.tipsRecommendArray = [NSMutableArray array];
    _ChangpingVC.tipsRecommendArray = [NSMutableArray array];
    _FengtaiVC.tipsRecommendArray = [NSMutableArray array];

    
    
    NSArray *subViewControllers = @[_HaidianVC,_ChaoyangVC,_DongchengVC,_XichengVC,_ChangpingVC,_FengtaiVC];
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    tabBarVC.view.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height );
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];


}

- (void)setNavBottomLine{
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];

}

@end
