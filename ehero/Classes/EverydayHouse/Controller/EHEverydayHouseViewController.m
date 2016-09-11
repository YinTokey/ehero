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
#import <MJExtension.h>
#import "AFNetworking.h"
#import "EHDistricts.h"
#import "WSDropMenuView.h"
#import "EHHouseSourcesCell.h"
#import "EHHouseSourcesMessage.h"

@interface EHEverydayHouseViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,UITextViewDelegate, WSDropMenuViewDataSource,WSDropMenuViewDelegate,houseSourcesDelegate>
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
- (IBAction)regionClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *regionBarButtom;
@property (nonatomic,strong) NSArray *districtsObjArray;


@end

@implementation EHEverydayHouseViewController
{
    NSInteger showMenuFlag;
    WSDropMenuView *dropMenu;
    EHHomeSearchBar *searchbar;
    BOOL canClickRegionBtn ;
    NSInteger hideCellsFlag;
    BOOL extendCellFlag;
    NSIndexPath *selIndexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];

    //设置顶部分割线
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];
    
    [self addGesture];
    self.tableView.bounces = NO;
    
    [YTHttpTool netCheck];
    
    [self getRegionInfo];
    
    [self getHouseResources];
    
}

- (void)addGesture{
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
}

#pragma mark - 编辑完成，点击搜索时调用代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [searchbar resignFirstResponder];
    
    return YES;
}


#pragma mark  -- UITapGestureRecognizer
- (void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [searchbar resignFirstResponder];
}



- (void)setupNavBar{
    searchbar = [[EHHomeSearchBar alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth, 30)];
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
    
    //弹窗菜单
    dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.1)];
    dropMenu.dataSource = self;
    dropMenu.delegate = self;
    [self.view addSubview:dropMenu];
   // UIBarButtonItem *menuBarBtn = [[UIBarButtonItem alloc] initWithCustomView:dropMenu];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer1,backItem,_regionBarButtom];
    
}

- (void)NavPop{
    [[self navigationController]popViewControllerAnimated:YES];
 
}

- (void)getRegionInfo{
    [LBProgressHUD showHUDto:self.view animated:NO];
    [YTHttpTool get:getRegionsInfoUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
     //数据处理
      NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
      NSDictionary *dic = [responseArray firstObject];
      NSArray *districtsArray = [dic objectForKey:@"districts"];
      _districtsObjArray = [EHDistricts mj_objectArrayWithKeyValuesArray:districtsArray];
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        canClickRegionBtn = YES;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

#pragma mark - get house resources
- (void)getHouseResources{
    [YTHttpTool get:houseSourcesUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        NSDictionary *dic = [responseArray firstObject];
        NSArray *HousesArray = [dic objectForKey:@"houses"];
        NSDictionary *Housedic  = [HousesArray firstObject];
        // NSLog(@"%@", [a class]);

    } failure:^(NSError *error) {
        NSLog(@"failed");
    }];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (extendCellFlag ) {
      return 360;
    }
    return 300;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    EHHouseSourcesCell *cell = [EHHouseSourcesCell houseSourcesCellWithTableView:tableView];
    
    cell.textView.delegate = self;
    cell.delegate = self;
    [cell setClickEvent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (extendCellFlag) {
       [cell.extendBtn setBackgroundImage:[UIImage imageNamed:@"houseDetail_less"] forState:UIControlStateNormal];
    }else{
       [cell.extendBtn setBackgroundImage:[UIImage imageNamed:@"houseDetail_more"] forState:UIControlStateNormal];
    }

    return cell;
}


- (IBAction)regionClick:(id)sender {
    if (canClickRegionBtn == YES) {
        [dropMenu clickAction];
        
    }
}

- (NSInteger)dropMenuView:(WSDropMenuView *)dropMenuView numberWithIndexPath:(WSIndexPath *)indexPath{
    
    //WSIndexPath 类里面有注释
    
    if (indexPath.column == 0 && indexPath.row == WSNoFound) {
        //北京15个区
        return 15;
    }
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
        EHDistricts *district = self.districtsObjArray[indexPath.row];
        return district.regions.count;
      
    }
    
    return 0;
}

- (NSString *)dropMenuView:(WSDropMenuView *)dropMenuView titleWithIndexPath:(WSIndexPath *)indexPath{
    //左边 第一级
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item == WSNoFound) {
         EHDistricts *district = self.districtsObjArray[indexPath.row];
         return district.district;
    }
    
    if (indexPath.column == 0 && indexPath.row != WSNoFound && indexPath.item != WSNoFound && indexPath.rank == WSNoFound) {
            EHDistricts *district = self.districtsObjArray[indexPath.row];
            NSString *regionStr = district.regions[indexPath.item];
            return regionStr;
    }
    return @"";
}

#pragma mark - WSDropMenuView Delegate -

- (void)dropMenuView:(WSDropMenuView *)dropMenuView didSelectWithIndexPath:(WSIndexPath *)indexPath{

    EHDistricts *district = self.districtsObjArray[indexPath.row];
    NSString *regionStr = district.regions[indexPath.item];
    
    searchbar.text = regionStr;
    
    NSLog(@"sel %@",regionStr);
}

- (void)extendBtnClick:(EHHouseSourcesCell *)cell{

    extendCellFlag = !extendCellFlag;
    selIndexPath = [self.tableView indexPathForCell:cell];
    [self.tableView reloadData];
}

@end
