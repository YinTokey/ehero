//
//  EHHomeViewController.m
//  ehero
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeViewController.h"
#import <SDCycleScrollView.h>
#import "buttonCell.h"
#import "EHEverydayhouseCell.h"
#import "XTPopView.h"
#import "EHTipsViewController.h"
#import "EHEverydayHouseViewController.h"
#import "EHAntidisturbViewController.h"
#import "EHWechatGroupViewController.h"
#import "EHCommentAgentViewController.h"
#import "YTSearchBar.h"
#import "EHHouseDetailViewController.h"

#import "AppDelegate.h"
#import "SDAutoLayout.h"
#import "EHHomeSearchBar.h"
#import "EHSearchViewController.h"
#import "EHHomeAgentCell.h"
#import "EHSiteButton.h"
#import "EHHomePopView.h"
#
@interface EHHomeViewController ()<selectIndexPathDelegate,buttonCellDelegate,UITextFieldDelegate>
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
/** 地点*/
@property (nonatomic,copy) NSString *siteString;

@end

@implementation EHHomeViewController
{
    NSInteger selectedFlag;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //设置轮播图片
    sourceArr = [NSMutableArray arrayWithObjects:@"img_00",@"img_01",@"img_02", nil];
    //读取用户偏好
    [self readDefaults];
    
    [self setNavBar];
    [self setupHeaderView];
    
    [YTHttpTool netCheck];
    
  

}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)readDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *siteString = [defaults objectForKey:@"siteString"];
    if (siteString.length > 1) {
        [self.siteBtn setTitle:siteString forState:UIControlStateNormal];
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 3) {
        return 5;
    }else{
        return 1;
    }

}

#pragma mark - section高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }else{
        return  0;
    }
}

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return self.view.frame.size.width * 0.246875;
    }else if(indexPath.section == 1){
        return 30;
    }else if(indexPath.section == 2){
        return 85;
    }else{
        return 94;
    }
}

#pragma mark - cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"reuseCell";
    //第一行 4个按钮
    if (indexPath.section == 0) {
        buttonCell *cell = [buttonCell buttonCellWithTableView:tableView];
        cell.delegate = self;
        [cell setClickEvent];
        return cell;
    //第二行 点评经纪人
    }else if(indexPath.section == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.text = @"评价你的经纪人";
        return cell;
    //第三行，显示一个经纪人
    }else if(indexPath.section == 2){
        EHHomeAgentCell *cell = [EHHomeAgentCell homeAgentCellWithTableView:tableView];
        return cell;
        
    //第四行 每日一房
    }else{
        
        EHEverydayhouseCell *cell = [EHEverydayhouseCell everydayhouseCellWithTableView:tableView];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        EHCommentAgentViewController *commentAgentViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"CommentAgentViewController"];
        [self.navigationController pushViewController:commentAgentViewController animated:YES];
    }
    if (indexPath.section == 3) {
        EHHouseDetailViewController *houseDetailViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"HouseDetailViewController"];
        [self.navigationController pushViewController:houseDetailViewController animated:YES];
    }
}


- (void)setupHeaderView{
   
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.tableView.frame.size.width - 10, ScreenHeight * 0.3) imageNamesGroup:sourceArr];
    cycleScrollView.autoScrollTimeInterval = 3.5;
    self.tableView.tableHeaderView = cycleScrollView;
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
    homePopView.delegate = self;
    [homePopView popView];
}
#pragma mark - 实现代理方法，左上角弹窗点击事件
- (void)selectIndexPathRow:(NSInteger)index{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    switch (index) {
        case 0:
        {
           self.siteString = @"北京";
           [defaults setObject:_siteString forKey:@"siteString"];
           [self.siteBtn setTitle:_siteString forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            self.siteString = @"上海";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteBtn setTitle:_siteString forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
           self.siteString = @"广州";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteBtn setTitle:_siteString forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            self.siteString = @"深圳";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteBtn setTitle:_siteString forState:UIControlStateNormal];
        }
        default:
            break;
    }
}
#pragma mark - 实现自定义cell里按钮点击的代理方法
- (void)firstBtnClick:(UITableViewCell *)cell{
    EHTipsViewController  *tipsViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"TipsViewController"];
    [self.navigationController pushViewController:tipsViewController animated:YES];

}

- (void)secondBtnClick:(UITableViewCell *)cell{
    
    EHAntidisturbViewController *antidisturbViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"AntidisturbViewController"];
    [self.navigationController pushViewController:antidisturbViewController animated:YES];
    
}

- (void)thirdBtnClick:(UITableViewCell *)cell{
    EHEverydayHouseViewController *everydayHouseViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"EverydayHouseViewController"];
    [self.navigationController pushViewController:everydayHouseViewController animated:YES];
}

- (void)fourthBtnClick:(UITableViewCell *)cell{

    EHWechatGroupViewController *wechatGroupViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"WechatGroupViewController"];
    [self.navigationController pushViewController:wechatGroupViewController animated:YES];

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
