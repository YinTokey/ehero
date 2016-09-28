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
#import "EHHousesInfo.h"
#import "EHHouseSummaryCell.h"
#import "EHAgentInfo.h"


@interface EHEverydayHouseViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate, WSDropMenuViewDataSource,WSDropMenuViewDelegate,houseSourcesDelegate,EHHomeSearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *regionBarButtom;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *typeBarButton;
@property (weak, nonatomic) IBOutlet UIButton *typeButton;
- (IBAction)typeBtnClick:(id)sender;
- (IBAction)regionClick:(id)sender;

@property (nonatomic,strong) NSArray *districtsObjArray;
@property (nonatomic,strong) EHHousesInfo *houseInfo;

@property (nonatomic,strong) NSMutableArray *houseInfoArray;
@property (nonatomic,strong) NSMutableArray *agentInfoArray;

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

    BOOL selectedFlag;
    NSString *type;
    
}

- (NSMutableArray *)houseInfoArray{
    if (_houseInfoArray == nil) {
        _houseInfoArray = [NSMutableArray array];
    }
    return  _houseInfoArray;
}

- (NSMutableArray *)agentInfoArray{
    if (_agentInfoArray == nil) {
        _agentInfoArray = [NSMutableArray array];
    }
    return _agentInfoArray;

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

  //  [YTHttpTool netCheck];
    
    [self getRegionInfo];
    
    [self getHouseResources];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = RGB(241, 243, 245);
 
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
    [self searchHouses];
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
    searchbar.EHSearchBtndelegate = self;
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
    self.navigationItem.leftBarButtonItems = @[negativeSpacer1,backItem,_regionBarButtom];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer1,_typeBarButton];
}

#pragma mark - 搜索栏右边按钮代理
- (void)searchBtnClick{
    [self searchHouses];
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
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [MBProgressHUD showError:@"请求数据失败" toView:self.view];
        NSLog(@"%@",error);
    }];

}

- (void)searchHouses{
    NSDictionary *param = @{@"arg":searchbar.text};
    [LBProgressHUD showHUDto:self.view animated:NO];
    [self.houseInfoArray removeAllObjects];
    [self.agentInfoArray removeAllObjects];
    [YTHttpTool get:houseSearchUrlStr params:param success:^(NSURLSessionDataTask *task, id responseObj) {
        //数据处理
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        self.agentInfoArray = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseArray];
        NSDictionary *dic = [responseArray firstObject];
        NSArray *houseArr = [dic objectForKey:@"houses"];//里面存字典，不是对象
        //后面是对于一些细节的处理
        for (NSDictionary *houseDic in houseArr){
            EHHousesInfo *houseInfo = [EHHousesInfo mj_objectWithKeyValues:houseDic];
            houseInfo.name = [dic objectForKey:@"name"];
            houseInfo.descriptions = [houseDic objectForKey:@"description"];
            [self.houseInfoArray addObject:houseInfo];
        }
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [self.tableView reloadData];
        [self searchStatusTest];
    } failure:^(NSError *error) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [MBProgressHUD showError:@"数据请求失败" toView:self.view];
    }];
}

- (void)searchStatusTest{
    
    if (self.houseInfoArray.count == 0) {
        [MBProgressHUD showError:@"没有找到房源" toView:self.view];
    }else{
        [MBProgressHUD showSuccess:@"为您找到房源" toView:self.view];
    }
    
}


#pragma mark - get house resources
- (void)getHouseResources{
    [self.agentInfoArray removeAllObjects];
    [self.houseInfoArray removeAllObjects];
    [YTHttpTool get:houseSourcesUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
        //数据处理
        
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        self.agentInfoArray = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseArray];
        NSDictionary *dic = [responseArray firstObject];
        NSArray *houseArr = [dic objectForKey:@"houses"];//里面存字典，不是对象
        //后面是对于一些细节的处理
        for (NSDictionary *houseDic in houseArr){
            EHHousesInfo *houseInfo = [EHHousesInfo mj_objectWithKeyValues:houseDic];
            houseInfo.name = [dic objectForKey:@"name"];
            houseInfo.descriptions = [houseDic objectForKey:@"description"];
            [self.houseInfoArray addObject:houseInfo];
        }

        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"没有找到房源" toView:self.view];
    }];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows

    return _houseInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 97;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    EHEverydayhouseCell *cell = [EHEverydayhouseCell everydayhouseCellWithTableView:tableView];
    cell.houseInfo = _houseInfoArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHHouseDetailViewController *VC = [[self storyboard]instantiateViewControllerWithIdentifier:@"HouseDetailViewController"];
    VC.houseInfo = _houseInfoArray[indexPath.row];
  //  VC.agentInfo = _agentInfoArray[0];
     VC.agentInfo = _agentInfoArray[indexPath.row];
    [VC.agentInfo getIdStringFromDictionary];

    [self.navigationController pushViewController:VC animated:YES];
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
    [self searchHouses];
   // NSLog(@"sel %@",regionStr);
}

- (void)extendBtnClick:(EHHouseSourcesCell *)cell{

    extendCellFlag = !extendCellFlag;
    selIndexPath = [self.tableView indexPathForCell:cell];
    [self.tableView reloadData];
}

- (IBAction)typeBtnClick:(id)sender {
    selectedFlag =! selectedFlag;
    self.typeButton.selected = YES;
    if (selectedFlag) {
        self.typeButton.selected = YES;
        type = @"rent";
    }else{
        self.typeButton.selected = NO;
        type = @"sale";
    }
    
}
@end
