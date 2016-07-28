//
//  EHSearchResultCell.h
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHAgentInfo.h"

@protocol EHSearchResultCellDelegate  <NSObject>

- (void)callBtnClick:(UITableViewCell *)cell;

@end



@interface EHSearchResultCell : UITableViewCell

+ (instancetype)searchResultCellWithTableView:(UITableView *)tableView;

- (void)setResultCell:(EHAgentInfo *)agentInfo;

@property (nonatomic,weak)id <EHSearchResultCellDelegate> delegate;

@end
