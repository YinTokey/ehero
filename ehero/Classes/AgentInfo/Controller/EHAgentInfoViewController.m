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
    

}



@end
