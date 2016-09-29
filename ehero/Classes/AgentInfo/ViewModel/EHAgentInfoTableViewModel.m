//
//  EHAgentInfoTableViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoTableViewModel.h"
#import "EHAgentInfoChartCell.h"
#import "EHNoCommentCell.h"

@implementation EHAgentInfoTableViewModel

#pragma mark - Table view data source

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1){
        return ScreenHeight * 0.42 + 30;
    }else if (indexPath.section == 2){
        return 36;
    }else{

        if (self.commentKind == 1) {
            if ([self.niceCommentsArray isKindOfClass:[NSArray class]] && self.niceCommentsArray.count <1) {
                return 102;
            }else{
                EHCommentInfo *comment = self.niceCommentsArray[indexPath.row];
                return comment.cellHeight;
            }
        }
        if (self.commentKind == 2) {
            if ([self.commonCommentsArray isKindOfClass:[NSArray class]] && self.commonCommentsArray.count <1) {
                return  102;
            }else{
                EHCommentInfo *comment = self.commonCommentsArray[indexPath.row];
                return comment.cellHeight;
            }
        }
        if (self.commentKind == 3)
        {
            if ( [self.badCommentsArray isKindOfClass:[NSArray class]] && self.badCommentsArray.count <1) {
                return 102;
            }else{
                EHCommentInfo *comment = self.badCommentsArray[indexPath.row];
                return comment.cellHeight;
            }
        }
        return 0;
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0 || section == 1 || section == 2) {
        return 1;
    }else{
         if (self.commentKind == 1) {
                if ([self.niceCommentsArray isKindOfClass:[NSArray class]] && self.niceCommentsArray.count == 0) {
                    return 1;
                }else{
                    return self.niceCommentsArray.count;
                }
            }
         if (self.commentKind == 2) {
                if ([self.commonCommentsArray isKindOfClass:[NSArray class]] && self.commonCommentsArray.count <1) {
                    return  1;
                }else{
                    return self.commonCommentsArray.count;
                }
            }
        if (self.commentKind == 3)
        {
                if ( [self.badCommentsArray isKindOfClass:[NSArray class]] && self.badCommentsArray.count <1) {
                    return 1;
                }else{
                    return self.badCommentsArray.count;
                }
        }
        return 0;
    }        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
        [cell setResultCell:self.agentInfo];
        cell.isdrawRect = NO;
        cell.delegate = self.superVC;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        EHAgentInfoChartCell *cell = [EHAgentInfoChartCell AgentInfoChartCellWithTableView:tableView];
        cell.backgroundColor = RGB(235, 247, 255);
        cell.chart.dataSource = self;
        cell.chart.delegate = self;
        [cell.chart reloadData];
        NSString *averageStr = [NSString stringWithFormat:@"%@平均值",self.agentInfo.company];
        cell.average.text = averageStr;
        NSString *personStr = [NSString stringWithFormat:@"%@能力值",self.agentInfo.name];
        cell.person.text = personStr;

        [RACObserve(self, averageInfo)subscribeNext:^(id x) {
            cell.chartView.hidden = NO;
            [cell.chart reloadData];
            
        }];
        
        return cell;
    }else if (indexPath.section == 2){
        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];
        cell.commentsArray = self.commentsArray;
        [cell setCommentCounts];
        cell.delegate = self;
        if (self.commentKind == 1) {
            cell.commonTriagle.hidden = YES;
            cell.badTriangle.hidden = YES;
            cell.niceTriangle.hidden = NO;
        }else if(self.commentKind == 2){
            cell.niceTriangle.hidden = YES;
            cell.badTriangle.hidden = YES;
            cell.commonTriagle.hidden = NO;
        }else{
            cell.commonTriagle.hidden = YES;
            cell.niceTriangle.hidden = YES;
            cell.badTriangle.hidden = NO;
        }
        return cell;
    }else{
        EHCommentDetailCell *commentCell = [EHCommentDetailCell commentDetailCellCellWithTableView:tableView];
        EHNoCommentCell *noCommentCell = [EHNoCommentCell noCommentCellCellWithTableView:tableView];
        if (self.commentKind == 1) {
            
            if ( [self.niceCommentsArray isKindOfClass:[NSArray class]] && self.niceCommentsArray.count <1){
                return noCommentCell;
            }else{
               commentCell.commentInfo = self.niceCommentsArray[indexPath.row];
                return commentCell;
            }
        }
        if(self.commentKind == 2){
            if ( [self.commonCommentsArray isKindOfClass:[NSArray class]] && self.commonCommentsArray.count <1){
                return noCommentCell;
            }else{
                commentCell.commentInfo = self.commonCommentsArray[indexPath.row];
                return commentCell;
            }

        }
        if(self.commentKind == 3)
        {
            if ( [self.badCommentsArray isKindOfClass:[NSArray class]] && self.badCommentsArray.count <1){
                return noCommentCell;
            }else{
                commentCell.commentInfo = self.badCommentsArray[indexPath.row];
                return commentCell;
            }

        }
        return noCommentCell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        EHCommentDetailCell *cell = [EHCommentDetailCell commentDetailCellCellWithTableView:tableView];
        cell.commentInfo = self.commentsArray[indexPath.row];
//        NSLog(@"label height %f",cell.rect.size.height);
//        NSLog(@"cell height %f",cell.frame.size.height);
    }
}
#pragma mark - 评价筛选按钮
- (void)niceClick:(UITableViewCell *)cell{
    self.commentKind = 1;
   
}

- (void)commonClick:(UITableViewCell *)cell{
    self.commentKind = 2;
  
}

- (void)badClick:(UITableViewCell *)cell{
    self.commentKind = 3;

}

#pragma mark - 雷达图代理
- (NSInteger)numberOfStepForRadarChart:(LQRadarChart *)radarChart
{
    return 10;
}
- (NSInteger)numberOfRowForRadarChart:(LQRadarChart *)radarChart
{
    return 5;
}
- (NSInteger)numberOfSectionForRadarChart:(LQRadarChart *)radarChart
{
    return 2;
}
- (NSString *)titleOfRowForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row
{
    if ([self.agentInfo.company isEqualToString:@"链家"]) {
        NSArray * title = @[@"成交量",@"委托量",@"带看量",@"好评率",@"评论数量"];
        return title[row];
    }else if ([self.agentInfo.company isEqualToString:@"我爱我家"]) {
        NSArray * title = @[@"售",@"租",@"关注量",@"好评率",@"浏览量"];
        return title[row];
    }else{
        NSArray * title = @[@"在售",@"在租",@"粉丝数量",@"服务客户数",@"近期成交量"];
        return title[row];
    }
    
}
#pragma mark - section 0 是蓝色， section 1是紫色。 峰值是5, 计算时 5 *（算出的百分比）
- (CGFloat)valueOfSectionForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row section:(NSInteger)section
{
    if (section == 0 ){
        NSArray *percentArray = [self.agentInfo percentageWithMaxValue:self.averageInfo];
        NSNumber *percentage = percentArray[row];
        CGFloat Floatpercentage = [percentage floatValue];
        if (Floatpercentage > 1.0) {
            Floatpercentage = 1;
        }
        return 5 * Floatpercentage;

    } else {
        if ([self.agentInfo.company isEqualToString:@"链家"]) {
            NSArray *percentArray = [self.averageInfo percentOfLianjia];
            NSNumber *percentage = percentArray[row];
            CGFloat Floatpercentage = [percentage floatValue];
            return 5 * Floatpercentage;
        }else if([self.agentInfo.company isEqualToString:@"我爱我家"]){
            NSArray *percentArray = [self.averageInfo percentOfWawj];
            NSNumber *percentage = percentArray[row];
            CGFloat Floatpercentage = [percentage floatValue];
            return 5 * Floatpercentage;
        }else{
            NSArray *percentArray = [self.averageInfo percentOfMaitian];
            NSNumber *percentage = percentArray[row];
            CGFloat Floatpercentage = [percentage floatValue];
            return 5 * Floatpercentage * 2;  //麦田的百分比较小，乘以2
        }

    }
}



- (UIColor *)colorOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIColor blackColor];
   
}
- (UIColor *)colorOfLineForRadarChart:(LQRadarChart *)radarChart
{
    return RGB(192,191, 190);
    
}
- (UIColor *)colorOfFillStepForRadarChart:(LQRadarChart *)radarChart step:(NSInteger)step
{
    UIColor * color = [UIColor clearColor];
    return color;
}
- (UIColor *)colorOfSectionFillForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return RGBA(22, 127, 246,0.3);
    }else{
        return RGBA(138, 142, 165,0.3);
    }
}
//数据组边框颜色
- (UIColor *)colorOfSectionBorderForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return RGB(22, 127, 246);
    }else{
        return RGB(138, 142, 165);
    }
    
}
- (UIFont *)fontOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIFont systemFontOfSize:11];
    
}

@end
