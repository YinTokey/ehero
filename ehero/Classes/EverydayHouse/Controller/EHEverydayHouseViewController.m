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
#import "XTPopView.h"

@interface EHEverydayHouseViewController ()<selectIndexPathDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *regionBtn;
- (IBAction)regionClick:(id)sender;

@end

@implementation EHEverydayHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];

    //设置顶部分割线
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];
    
    [YTHttpTool netCheck];
}

- (void)setupNavBar{
    EHHomeSearchBar *searchbar = [[EHHomeSearchBar alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth, 30)];
    searchbar.placeholder = @"搜索地区或商圈房源";
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    self.navigationItem.titleView = searchbar;
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 14, 23.6);
    [leftBtn setImage:[UIImage imageNamed:@"Back Arrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(NavPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.hidesBackButton = YES;
    
    
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
    CGPoint point = CGPointMake(_regionBtn.center.x,_regionBtn.center.y + 45);
    XTPopView *popView = [[XTPopView alloc] initWithOrigin:point Width:80 Height:40 * 4 Type:XTTypeOfUpCenter Color:[UIColor whiteColor] superView:self.view];
    popView.dataArray = @[@"三里屯",@"CBD",@"五道口", @"望京"];
    popView.fontSize = 13;
    popView.row_height = 40;
    popView.titleTextColor = [UIColor blackColor];
    popView.delegate = self;
    [popView popView];
    
}
@end
