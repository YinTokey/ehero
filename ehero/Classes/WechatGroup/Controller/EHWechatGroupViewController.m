//
//  EHWechatGroupViewController.m
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHWechatGroupViewController.h"
#import "EHWechatGroupCell.h"
#import <Photos/Photos.h>
#import "EHWechatGroupDetailViewController.h"
/** 相册名字 */
static NSString * const XMGCollectionName = @"易房好介-Photos";

@interface EHWechatGroupViewController ()

@end

@implementation EHWechatGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [YTHttpTool netCheck];
    NSLog(@"wechatGroup");
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EHWechatGroupCell *cell = [EHWechatGroupCell wechatGroupCellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 280;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    EHWechatGroupDetailViewController *VC = [[self storyboard]instantiateViewControllerWithIdentifier:@"WechatGroupDetailViewController"];
    [self.navigationController pushViewController:VC animated:YES];

}









@end
