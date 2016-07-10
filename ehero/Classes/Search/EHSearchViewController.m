//
//  EHSearchViewController.m
//  ehero
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchViewController.h"
#import "YTSearchBar.h"
#import "UIBarButtonItem+Extension.h"
#import "EHSearchResultCell.h"

@interface EHSearchViewController ()


@property (nonatomic, strong) YTSearchBar *searchBar;
@end

@implementation EHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

   self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"租房"
                                                                              target:self
                                                                              action:@selector(selections)];
    self.searchBar = [YTSearchBar searchBarWithPlaceholder:@"区域,经纪人"];
    self.navigationItem.titleView = _searchBar;
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
    
    
    return cell;
}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124;
}

- (void)selections{
    NSLog(@"sele");
}


@end
