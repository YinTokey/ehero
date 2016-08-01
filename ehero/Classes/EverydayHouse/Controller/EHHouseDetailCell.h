//
//  EHHouseDetailCell.h
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHHouseDetailCell : UITableViewCell

+ (instancetype)houseDetailCellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *blueView1;
@property (weak, nonatomic) IBOutlet UIImageView *blueView2;
@property (weak, nonatomic) IBOutlet UIImageView *blueView3;
@property (weak, nonatomic) IBOutlet UIView *grayView;




@end
