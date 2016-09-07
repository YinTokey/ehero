//
//  EHAgentInfoTableViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoTableViewModel.h"
#import "EHAgentInfoChartCell.h"
#import "EHAgentInfoCommentCell.h"


@implementation EHAgentInfoTableViewModel

//1 懒加载
- (NSMutableArray *)commentFrames
{
    if (_commentFrames == nil) {
        //1.1 加载模型数据
        EHCommentInfo *commentInfo = [[EHCommentInfo alloc]init];
        commentInfo.text = @"ksjdfkjslkajfksjfj;alkjfk;ldsja;jdlkfjsldjfksdjf;sk;fsjf;sjieg";
        NSArray *comments = @[commentInfo];
        NSMutableArray *tmpArray = [NSMutableArray array];
        //1.2 创建frame模型
        for (EHCommentInfo *comment in comments) {
            EHCommentFrame *commentFrame = [[EHCommentFrame alloc] init];
            commentFrame.commentInfo = comment;
            
            [tmpArray addObject:commentFrame];
        }
        _commentFrames = tmpArray;
    }
    return _commentFrames;
}

#pragma mark - Table view data source

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1){
        return ScreenHeight * 0.42 + 30;
    }else if (indexPath.section == 2){
        return 30;
    }else{
        return [self.commentFrames[indexPath.row] rowHeight];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0 || section == 1 || section == 2) {
        return 1;
    }else
        return self.commentFrames.count;
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
            [cell.chart reloadData];
            cell.chartView.hidden = NO;
        }];
        
        return cell;
    }else if (indexPath.section == 2){
        EHAgentInfoCommentCell *cell = [EHAgentInfoCommentCell AgentInfoCommentCellWithTableView:tableView];
        return cell;
    }else{
        EHCommentDetailCell *cell = [EHCommentDetailCell commentDetailCellCellWithTableView:tableView];
        cell.commentFrame = self.commentFrames[indexPath.row];
        return cell;
    }
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
