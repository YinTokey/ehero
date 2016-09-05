//
//  EHAgentInfoTableViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EHSearchResultCell.h"
#import "LQRadarChart.h"
@class EHAgentInfo;
@interface EHAgentInfoTableViewModel : NSObject<EHSearchResultCellDelegate,UITableViewDataSource,UITableViewDelegate,LQRadarChartDataSource,LQRadarChartDelegate>

@property (nonatomic,strong) EHAgentInfo *agentInfo;
@property (nonatomic,strong) id superVC;

@end
