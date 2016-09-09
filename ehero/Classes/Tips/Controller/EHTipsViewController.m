//
//  EHTipsViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewController.h"
#import "DCNavTabBarController.h"

#import "EHHaidianViewController.h"
#import "EHChangpingViewController.h"
#import "EHChaoyangViewController.h"
#import "EHDongchengViewController.h"


@interface EHTipsViewController ()



@end

@implementation EHTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildController];
    [self setNavBottomLine];
}

- (void)setupChildController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Tips" bundle:[NSBundle mainBundle]];
    
    EHHaidianViewController *one = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    one.title = @"海淀";
    EHHaidianViewController *two = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    two.title = @"朝阳";
    EHHaidianViewController *three = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    three.title = @"东城";
    EHHaidianViewController *four = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    four.title = @"昌平";
    EHHaidianViewController *five = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    five.title = @"顺义";
    EHHaidianViewController *six = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    six.title = @"大兴";
    EHHaidianViewController *seven = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    seven.title = @"西城";
    EHHaidianViewController *eight = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];    eight.title = @"通州";
    EHHaidianViewController *night = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    night.title = @"丰台";
    EHHaidianViewController *ten = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    ten.title = @"石景山";
    EHHaidianViewController *eleven = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    eleven.title = @"房山";
    
    NSArray *subViewControllers = @[one,two,three,four,five,six,seven,eight,night,ten,eleven];
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    tabBarVC.view.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height - 75);
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
}

- (void)setNavBottomLine{
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];

}

@end
