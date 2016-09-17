//
//  EHHouseDetailCallCell.h
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol detailCallCellDelegate <NSObject>

- (void)callClick:(UITableViewCell *)cell;

@end


@interface EHHouseDetailCallCell : UITableViewCell

- (IBAction)callClick:(id)sender;


+ (instancetype)houseDetailCallCellWithTableView:(UITableView *)tableView;

@property (nonatomic,weak)id<detailCallCellDelegate>delegate;

@end
