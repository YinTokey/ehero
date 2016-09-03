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

@protocol tipsViewCellDelegate <NSObject>

- (void)guessClick:(UITableViewCell *)cell;
- (void)moreClick:(UITableViewCell *)cell;

@end


@interface EHTipsViewCell : UITableViewCell

@property (nonatomic,strong) NewPagedFlowView *pageFlowView;

@property (nonatomic,weak)id<tipsViewCellDelegate> delegate;

+ (instancetype)tipsViewCellWithTableView:(UITableView *)tableView;

- (void)setClickEvent;

@end