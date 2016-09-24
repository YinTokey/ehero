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
#import "EHAverageInfo.h"
#import "EHCommentInfo.h"
#import "EHCommentDetailCell.h"
#import "EHAgentInfoCommentCell.h"

@class EHAgentInfo;
@interface EHAgentInfoTableViewModel : NSObject<EHSearchResultCellDelegate,UITableViewDataSource,UITableViewDelegate,LQRadarChartDataSource,LQRadarChartDelegate,agentInfoCommentCellDelegate>

@property (nonatomic,strong) EHAgentInfo *agentInfo;
@property (nonatomic,strong) EHAverageInfo *averageInfo;
@property (nonatomic,strong) id superVC;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@property (nonatomic, strong) NSMutableArray *niceCommentsArray;
@property (nonatomic, strong) NSMutableArray *commonCommentsArray;
@property (nonatomic, strong) NSMutableArray *badCommentsArray;


@property (nonatomic, strong) UITableViewCell *prototypeCell;
@property (nonatomic,assign) NSInteger commentKind;
@end
