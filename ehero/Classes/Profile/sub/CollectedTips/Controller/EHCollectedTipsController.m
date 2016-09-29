//
//  EHCollectedTipsController.m
//  ehero
//
//  Created by Mac on 16/9/3.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCollectedTipsController.h"
#import "EHTipsRecommend.h"
#import "EHTipsReaderViewController.h"


@interface EHCollectedTipsController ()

@property (nonatomic,strong) NSMutableArray *collectedTipsArray;

@end

@implementation EHCollectedTipsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
}

- (void)viewWillAppear:(BOOL)animated{
    //从数据库获取数据
    self.collectedTipsArray = [NSMutableArray arrayWithArray:[EHTipsRecommend findAll]];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _collectedTipsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuseCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
  //  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    EHTipsRecommend *tip = self.collectedTipsArray[indexPath.row];
    
    NSString *title = [NSString stringWithFormat:@"租房锦囊之 %@",tip.name];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //从数据库中删除对应的纪录
        EHTipsRecommend *tip = self.collectedTipsArray[indexPath.row];
        [tip deleteObject];
        
        //删除cell
        [self.collectedTipsArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    
    
    return @[action];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHTipsReaderViewController *tipsReaderVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"TipsReaderViewController"];
    EHTipsRecommend *tip = self.collectedTipsArray[indexPath.row];
    tipsReaderVC.tipsRecomnend = tip;
    [self.navigationController pushViewController:tipsReaderVC animated:YES];
}


@end
