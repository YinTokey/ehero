//
//  EHCollectedArticleViewController.m
//  ehero
//
//  Created by Mac on 16/8/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCollectedArticleViewController.h"
#import "EHSlides.h"
#import "EHOfficialAccountController.h"


@interface EHCollectedArticleViewController ()

@property (nonatomic,strong) NSMutableArray *collectedArticleArray;

@end

@implementation EHCollectedArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //从数据库获取数据
 //   self.collectedArticleArray = [NSMutableArray arrayWithArray:[EHSlides findAll]];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    
//    @weakify(self);
//    [RACObserve(self, collectedArticleArray) subscribeNext:^(id x) {
//        
//        @strongify(self);
//        [self.tableView reloadData];
//        
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    //从数据库获取数据
    self.collectedArticleArray = [NSMutableArray arrayWithArray:[EHSlides findAll]];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _collectedArticleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"reuseCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
    }
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    EHSlides *slide = self.collectedArticleArray[indexPath.row];
    cell.textLabel.text = slide.title;
    
    return cell;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //从数据库中删除对应的纪录
        EHSlides *slide = self.collectedArticleArray[indexPath.row];
        [slide deleteObject];
        
        //删除cell
        [self.collectedArticleArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    
    
    return @[action];
}

#pragma mark - 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHOfficialAccountController *officialAccountVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"OfficialAccountController"];
    EHSlides *slide = self.collectedArticleArray[indexPath.row];
    
    officialAccountVC.slide = slide;
    [self.navigationController pushViewController:officialAccountVC animated:YES];
}


@end
