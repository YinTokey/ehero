//
//  EHTipViewCell.h
//  易房好介
//
//  Created by Mac on 16/9/3.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@protocol tipViewCellDelegate <NSObject>

- (void)guessClick:(UITableViewCell *)cell;
- (void)moreClick:(UITableViewCell *)cell;

@end


@interface EHTipViewCell : UITableViewCell

@property (nonatomic,strong) NewPagedFlowView *pageFlowView;

@property (nonatomic,weak)id<tipViewCellDelegate> delegate;

+ (instancetype)tipViewCellWithTableView:(UITableView *)tableView;

- (void)setClickEvent;

@end
