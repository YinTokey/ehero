//
//  EHHouseDetailAgentCell.h
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHousesInfo.h"
#import "EHAgentInfo.h"


@interface EHHouseDetailAgentCell : UITableViewCell

+ (instancetype)houseDetailAgentCellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *percentile;

@property (weak, nonatomic) IBOutlet UILabel *company;

@property (weak, nonatomic) IBOutlet UITextView *descriptions;

@property (nonatomic,strong) EHHousesInfo *houseInfo;
@property (nonatomic,strong) EHAgentInfo *agetnInfo;
@property (weak, nonatomic) IBOutlet UIImageView *txView;

@end
