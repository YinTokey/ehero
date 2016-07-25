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
#import "EHAsiaViewController.h"

@interface EHTipsViewController ()



@end

@implementation EHTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildController];
    
}

- (void)setupChildController{
    EHTwoViewController *one = [[EHTwoViewController alloc]init];
    one.title = @"海淀";
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Tips" bundle:[NSBundle mainBundle]];
    
    EHAsiaViewController *two = [sb instantiateViewControllerWithIdentifier:@"AsiaViewController"];
    two.title = @"朝阳";
    EHTwoViewController *three = [[EHTwoViewController alloc]init];
    three.title = @"东城";
    EHTwoViewController *four = [[EHTwoViewController alloc]init];
    four.title = @"西城";
    EHTwoViewController *five = [[EHTwoViewController alloc]init];
    five.title = @"顺义";
    EHNewsViewController *six = [[EHNewsViewController alloc]init];
    six.title = @"大兴";
    EHNewsViewController *seven = [[EHNewsViewController alloc]init];
    seven.title = @"昌平";
    EHNewsViewController *eight = [[EHNewsViewController alloc]init];
    eight.title = @"通州";
    EHNewsViewController *night = [[EHNewsViewController alloc]init];
    night.title = @"丰台";
    EHNewsViewController *ten = [[EHNewsViewController alloc]init];
    ten.title = @"石景山";
    EHNewsViewController *eleven = [[EHNewsViewController alloc]init];
    eleven.title = @"房山";
    
    
    NSArray *subViewControllers = @[one,two,three,four,five,six,seven,eight,night,ten,eleven];
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    tabBarVC.view.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height - 75);
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
}

@end
