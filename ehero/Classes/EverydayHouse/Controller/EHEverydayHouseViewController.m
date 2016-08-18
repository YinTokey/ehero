//
//  EHEverydayHouseViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHEverydayHouseViewController.h"
#import "EHEverydayhouseCell.h"
#import "EHHouseDetailViewController.h"
#import "EHHomeSearchBar.h"
#import "SkyAssociationMenuView.h"
#import "YTHttpTool.h"
#import <MJExtension.h>
#import "AFNetworking.h"
#import "EHDistricts.h"


@interface EHEverydayHouseViewController ()<UITextFieldDelegate,SkyAssociationMenuViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
- (IBAction)regionClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *regionBarButtom;
@property (strong, nonatomic) SkyAssociationMenuView *menuView;
@property (nonatomic,strong) NSArray *districtsObjArray;


@end

@implementation EHEverydayHouseViewController
{
    NSInteger showMenuFlag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];

    //设置顶部分割线
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];
    
    [YTHttpTool netCheck];
    //设置二级菜单
    _menuView = [SkyAssociationMenuView new];
    _menuView.delegate = self;
    
    [self getRegionInfo];

}

- (void)setupNavBar{
    EHHomeSearchBar *searchbar = [[EHHomeSearchBar alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth, 30)];
    searchbar.placeholder = @"搜索地区或商圈房源";
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    self.navigationItem.titleView = searchbar;
    
    //自定义返回按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 14, 23.6);
    [leftBtn setImage:[UIImage imageNamed:@"Back Arrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(NavPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *negativeSpacer1 = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace target : nil action : nil ];

    negativeSpacer1.width = - 10 ;//这个数值可以根据情况自由变化
    self.navigationItem.leftBarButtonItems = @[negativeSpacer1,backItem,_regionBarButtom];
    
}

- (void)NavPop{
    [[self navigationController]popViewControllerAnimated:YES];
 
}

- (void)getRegionInfo{
    [YTHttpTool get:getRegionsInfoUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
     //数据处理
      NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
      NSDictionary *dic = [responseArray firstObject];
      NSArray *districtsArray = [dic objectForKey:@"districts"];
      _districtsObjArray = [EHDistricts mj_objectArrayWithKeyValuesArray:districtsArray];
        
        

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHEverydayhouseCell *cell = [EHEverydayhouseCell everydayhouseCellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    EHHouseDetailViewController *houseDetailViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"HouseDetailViewController"];
    [self.navigationController pushViewController:houseDetailViewController animated:YES];

}

- (IBAction)regionClick:(id)sender {

    [_menuView showAsDrawDownView:sender];

}



#pragma mark - tableview的cell的数量
- (NSInteger)assciationMenuView:(SkyAssociationMenuView*)asView countForClass:(NSInteger)idx {
    if (idx == 0) {
        return _districtsObjArray.count;
    }
    else{
        
        EHDistricts *district = self.districtsObjArray[idx];
        
        return district.regions.count ;
    }
//    if(idx == 0 && )
//    {
//        NSInteger regionsCount;
//        for(EHDistricts *district in _districtsObjArray )
//            regionsCount = district.regions.count;
//
//    }
}

#pragma mark - table1的内容
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 {
    EHDistricts *district = self.districtsObjArray[idx_1];
    
    return district.district;
   // return [NSString stringWithFormat:@"title %ld", idx_1];
}

#pragma mark - table2的内容
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    EHDistricts *district = self.districtsObjArray[idx_1];
    NSString *regionStr = district.regions[idx_2];
    
    return regionStr;
  //  return [NSString stringWithFormat:@"title %ld, %ld", idx_1, idx_2];
}

- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2{
    return NO;
}

- (void)menuDidSelectedAtIndex1:(SkyAssociationMenuView *)asView idxInClass1:(NSInteger)idx_1{
    NSLog(@"在控制器选择第一项");
}

- (void)menuDidSelectedAtIndex2:(SkyAssociationMenuView *)asView idxInClass2:(NSInteger)idx_2{
    NSLog(@"在控制器选择第二项");
}

@end
