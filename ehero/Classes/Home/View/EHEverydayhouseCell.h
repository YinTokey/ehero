//
//  EHEverydayhouseCell.h
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHousesInfo.h"


@interface EHEverydayhouseCell : UITableViewCell

+ (instancetype)everydayhouseCellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *updated_at;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;



@property (nonatomic,strong) EHHousesInfo *houseInfo;



@end
