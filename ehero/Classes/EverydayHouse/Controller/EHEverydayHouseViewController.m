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


@interface EHEverydayHouseViewController ()<UITextFieldDelegate,SkyAssociationMenuViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
- (IBAction)regionClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *regionBarButtom;
@property (strong, nonatomic) SkyAssociationMenuView *menuView;
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
    
    _menuView = [SkyAssociationMenuView new];
    _menuView.delegate = self;
 
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
        return 5;
    }else{
        return 10;
    }
}

#pragma mark - table1的内容
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 {
    return @"菜单1";
   // return [NSString stringWithFormat:@"title %ld", idx_1];
}

#pragma mark - table2的内容
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    return @"菜单2";
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
