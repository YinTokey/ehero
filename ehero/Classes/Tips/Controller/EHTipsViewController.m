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

static NSString * const MYKEY = @"UICollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];

//    EHNewsViewController *one = [[EHNewsViewController alloc]init];
//    one.title = @"one";
//    EHNewsViewController *two = [[EHNewsViewController alloc]init];
//    two.title = @"two";
//    EHNewsViewController *three = [[EHNewsViewController alloc]init];
//    three.title = @"three";
//    EHNewsViewController *four = [[EHNewsViewController alloc]init];
//    four.title = @"four";
//    EHNewsViewController *five = [[EHNewsViewController alloc]init];
//    five.title = @"five";

    EHTwoViewController *one = [[EHTwoViewController alloc]init];
    one.title = @"one";
    EHTwoViewController *two = [[EHTwoViewController alloc]init];
    two.title = @"two";
    EHTwoViewController *three = [[EHTwoViewController alloc]init];
    three.title = @"three";
    EHTwoViewController *four = [[EHTwoViewController alloc]init];
    four.title = @"four";
    EHTwoViewController *five = [[EHTwoViewController alloc]init];
    five.title = @"five";
    
    NSArray *subViewControllers = @[one,two,three,four,five];
    DCNavTabBarController *tabBarVC = [[DCNavTabBarController alloc]initWithSubViewControllers:subViewControllers];
    tabBarVC.view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
//    
   [self.view addSubview:tabBarVC.view];
    [self addChildViewController:tabBarVC];
    
    self.title = @"总控制器";

    
}


@end
