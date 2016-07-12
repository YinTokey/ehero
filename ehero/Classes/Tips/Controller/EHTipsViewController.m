//
//  EHTipsViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewController.h"
#import "EHNewsViewController.h"
#import "DCNavTabBarController.h"

#import "EHTwoViewController.h"


@interface EHTipsViewController ()



@end

@implementation EHTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildController];
    
}

- (void)setupChildController{
    EHTwoViewController *one = [[EHTwoViewController alloc]init];
    one.title = @"最新";
    EHTwoViewController *two = [[EHTwoViewController alloc]init];
    two.title = @"亚洲";
    EHTwoViewController *three = [[EHTwoViewController alloc]init];
    three.title = @"欧洲";
    EHTwoViewController *four = [[EHTwoViewController alloc]init];
    four.title = @"北美洲";
    EHTwoViewController *five = [[EHTwoViewController alloc]init];
    five.title = @"南美洲";
    EHNewsViewController *six = [[EHNewsViewController alloc]init];
    six.title = @"大洋洲";
    EHNewsViewController *seven = [[EHNewsViewController alloc]init];
    seven.title = @"非洲";
    
    NSArray *subViewControllers = @[one,two,three,four,five,six,seven];
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    tabBarVC.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
}

@end
