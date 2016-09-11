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
#import "EHXichengViewController.h"
#import "EHFengtaiViewController.h"

@interface EHTipsViewController ()


@end

@implementation EHTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildController];
    [self setNavBottomLine];
    
    NSLog(@"%d",self.tipsRecommendArray.count);
}

- (void)setupChildController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Tips" bundle:[NSBundle mainBundle]];
    
    EHHaidianViewController *one = [sb instantiateViewControllerWithIdentifier:@"HaidianViewController"];
    one.title = @"海淀";
    EHChaoyangViewController *two = [sb instantiateViewControllerWithIdentifier:@"ChaoyangViewController"];
    two.title = @"朝阳";
    EHDongchengViewController *three = [sb instantiateViewControllerWithIdentifier:@"DongchengViewController"];
    three.title = @"东城";
    EHXichengViewController *four = [sb instantiateViewControllerWithIdentifier:@"XichengViewController"];
    four.title = @"西城";
    EHChangpingViewController *five = [sb instantiateViewControllerWithIdentifier:@"ChangpingViewController"];
    five.title = @"昌平";
    EHFengtaiViewController *six = [sb instantiateViewControllerWithIdentifier:@"FengtaiViewController"];
    six.title = @"丰台";
    
    NSArray *subViewControllers = @[one,two,three,four,five,six];
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    tabBarVC.view.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height - 75);
    self.view.frame = CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height);
    
    
    [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
}

- (void)setNavBottomLine{
    EHTipsNavBottomLine *lineView = [EHTipsNavBottomLine initNavBottomLineWithController:self];
    [self.navigationController.navigationBar addSubview:lineView];

}

@end
