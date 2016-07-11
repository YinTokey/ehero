//
//  EHTipsViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewController.h"
#import "EHNewsViewController.h"
#import "ZJScrollPageView.h"


#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@interface EHTipsViewController ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;


@end

@implementation EHTipsViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球",
                    @"汽车",
                    @"囧途旅游",
                    @"幽默搞笑",
                    @"视频",
                    @"无厘头",
                    @"美女图片",
                    @"今日房价",
                    @"头像",
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
    
    
}

- (NSInteger)numberOfChildViewControllers{
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[UIViewController alloc] init];
    }
    
    if (index%2==0) {
        childVc.view.backgroundColor = [UIColor blueColor];
    } else {
        childVc.view.backgroundColor = [UIColor greenColor];
        
    }
    
    NSLog(@"%ld-----%@",(long)index, childVc);
    
    return childVc;


}


@end
