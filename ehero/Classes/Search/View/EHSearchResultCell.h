//
//  EHSearchResultCell.h
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHAgentInfo.h"
@interface EHSearchResultCell : UITableViewCell

+ (instancetype)searchResultCellWithTableView:(UITableView *)tableView;

- (void)setResultCell:(EHAgentInfo *)agentInfo;
@end
