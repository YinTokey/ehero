//
//  EHTipsViewCell.h
//  ehero
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
@interface EHTipsViewCell : UITableViewCell

@property (nonatomic,strong) NewPagedFlowView *pageFlowView;


+ (instancetype)tipsViewCellWithTableView:(UITableView *)tableView;

@end