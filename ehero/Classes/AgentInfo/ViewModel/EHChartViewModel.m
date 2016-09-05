//
//  EHChartViewModel.m
//  易房好介
//
//  Created by Mac on 16/9/5.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHChartViewModel.h"

@implementation EHChartViewModel

- (NSInteger)numberOfStepForRadarChart:(LQRadarChart *)radarChart
{
    return 10;
}
- (NSInteger)numberOfRowForRadarChart:(LQRadarChart *)radarChart
{
    return 5;
}
- (NSInteger)numberOfSectionForRadarChart:(LQRadarChart *)radarChart
{
    return 2;
}
- (NSString *)titleOfRowForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row
{
    NSArray * title = @[@"销售",@"出租",@"关注量",@"好评率",@"浏览量"];
    return title[row];
}
- (CGFloat)valueOfSectionForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row section:(NSInteger)section
{
    if (section == 0 ){
        return (CGFloat)(MAX(MIN(row + 1, 4), 3));
    } else {
        return (CGFloat)(MAX(MIN(row + 2, 5), 1));
    }
}



- (UIColor *)colorOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIColor blackColor];
    
}
- (UIColor *)colorOfLineForRadarChart:(LQRadarChart *)radarChart
{
    return RGB(192,191, 190);
    
}
- (UIColor *)colorOfFillStepForRadarChart:(LQRadarChart *)radarChart step:(NSInteger)step
{
    UIColor * color = [UIColor whiteColor];
    //    switch (step) {
    //        case 1:
    //            color = [UIColor colorWithRed:0.545 green:0.906 blue:0.996 alpha:1];
    //            break;
    //        case 2:
    //            color = [UIColor colorWithRed:0.706 green:0.929 blue:0.988 alpha:1];
    //            break;
    //        case 3:
    //            color = [UIColor colorWithRed:0.831 green:0.949 blue:0.984 alpha:1];
    //            break;
    //        case 4:
    //            color = [UIColor colorWithRed:0.922 green:0.976 blue:0.998 alpha:1];
    //            break;
    //
    //        default:
    //            break;
    //    }
    return color;
}
- (UIColor *)colorOfSectionFillForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return RGBA(22, 127, 246,0.3);
    }else{
        return RGBA(138, 142, 165,0.3);
    }
}
//数据组边框颜色
- (UIColor *)colorOfSectionBorderForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return RGB(22, 127, 246);
    }else{
        return RGB(138, 142, 165);
    }
    
}
- (UIFont *)fontOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIFont systemFontOfSize:11];
    
}



@end
