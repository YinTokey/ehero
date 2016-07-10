//
//  EHAgentInfoViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JJRadarChart.h"
@interface EHAgentInfoViewController ()<JJRadarChartDataSource, JJRadarChartDelegate>
{
   JJRadarChart *chart;
}

@property (weak, nonatomic) IBOutlet UITextView *comment;
@property (weak, nonatomic) IBOutlet UIView *radarChartView;
@end

@implementation EHAgentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFrame];
    
    [self setupRadarChart];
}

- (void)setupFrame{
    
    self.comment.layer.borderColor = [UIColor grayColor].CGColor;
    self.comment.layer.borderWidth = 1.0;
    self.comment.layer.cornerRadius = 5.0;
}

- (void)setupRadarChart{
    chart = [[JJRadarChart alloc] initWithFrame:CGRectMake(0, 0, self.radarChartView.frame.size.width, self.radarChartView.frame.size.width)];
    chart.center = CGPointMake(half(self.radarChartView.frame.size.width), half(self.radarChartView.frame.size.height));
    chart.dataSource = self;
    chart.delegate = self;
    [self.radarChartView addSubview:chart];
}
#pragma mark - JJRadarChartDataSource
- (NSInteger)numberOfItemsInRadarChart:(JJRadarChart *)radarChart {
    //一共5组, 模拟
    return 5;
}
- (NSInteger)radarChart:(JJRadarChart *)radarChart maxCountAtIndex:(NSInteger)index {
    //每组最大100, 模拟
    return 100;
}
- (NSInteger)radarChart:(JJRadarChart *)radarChart rankAtIndex:(NSInteger)index {
    //分别设置每一个维度的数值
    if (index == 0) {
        return  20;
    }else if(index == 1){
        return 30;
    }else if(index == 2){
        return 40;
    }else if(index == 3){
        return 60;
    }else{
        return 80;
    }

}
- (NSString *)radarChart:(JJRadarChart *)radarChart titleOfItemAtIndex:(NSInteger)index {
    //模拟数据
    NSArray *arr = @[@"信用", @"效率", @"态度", @"房源", @"售后"];
    return arr[index];
}

@end
