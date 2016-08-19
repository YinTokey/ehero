//
//  EHHouseSourcesCell.m
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseSourcesCell.h"
#import <SDCycleScrollView.h>
@implementation EHHouseSourcesCell

+ (instancetype)houseSourcesCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"HouseSourcesCell";
    //设置轮播图片
   NSMutableArray *sourceArr = [NSMutableArray arrayWithObjects:@"house1",@"house2",@"house3", nil];
    
    
    EHHouseSourcesCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseSourcesCell" owner:nil options:nil] lastObject];
        
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 0.23) imageNamesGroup:sourceArr];
        cycleScrollView.autoScrollTimeInterval = 300;
        [cell addSubview:cycleScrollView];
        
    }
    
    return cell;
    
}


@end
