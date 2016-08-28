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
    self.collectedArticleArray = [NSMutableArray arrayWithArray:[EHSlides findAll]];
    //跳转到下一界面的返回按钮样式
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
}

- (void)viewWillAppear:(BOOL)animated{
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
    EHSlides *slide = self.collectedArticleArray[indexPath.row];
    cell.textLabel.text = slide.title;
    
    return cell;
}



@end
