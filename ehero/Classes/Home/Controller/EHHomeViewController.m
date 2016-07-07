//
//  EHHomeViewController.m
//  ehero
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeViewController.h"
#import <SDCycleScrollView.h>
@interface EHHomeViewController ()
{
    /** 图片数组*/
    NSMutableArray *sourceArr;
}




@end

@implementation EHHomeViewController

#pragma mark -- 懒加载图片数组

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sourceArr = [NSMutableArray arrayWithObjects:@"img_00",@"img_01",@"img_02",@"img_03",@"img_04", nil];
    
    [self setupHeaderView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (void)setupHeaderView{

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 10, 150) imageNamesGroup:sourceArr];
    self.tableView.tableHeaderView = cycleScrollView;
}
@end
