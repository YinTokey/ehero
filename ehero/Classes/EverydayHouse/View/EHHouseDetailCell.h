//
//  EHHouseDetailCell.h
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
#import "EHHousesInfo.h"

@interface EHHouseDetailCell : UITableViewCell

+ (instancetype)houseDetailCellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *blueView1;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updated_at;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *area;
@property (weak, nonatomic) IBOutlet UILabel *toward;
@property (weak, nonatomic) IBOutlet UILabel *floor;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *click;

@property (nonatomic,strong)EHHousesInfo *houseInfo;


@end
