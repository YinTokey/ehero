//
//  EHHouseSummaryCell.h
//  易房好介
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHousesInfo.h"

@interface EHHouseSummaryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (nonatomic,strong) EHHousesInfo *houseInfo;

+ (instancetype)houseSummaryCellWithTableView:(UITableView *)tableView;

@end
