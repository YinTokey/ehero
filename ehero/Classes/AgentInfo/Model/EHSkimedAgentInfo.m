//
//  EHSkimedAgentInfo.m
//  ehero
//
//  Created by Mac on 16/8/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSkimedAgentInfo.h"

@implementation EHSkimedAgentInfo

- (void)setWithAgentInfoAndTimeLabel:(EHAgentInfo *)agentInfo{
    //获取系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel = [dateformatter stringFromDate:senddate];
    
    self._id = agentInfo._id;
    self.idStr = agentInfo.idStr;
    self._slugs = agentInfo._slugs;
    self.career = agentInfo.career;
    self.city = agentInfo.city;
    self.clicks = agentInfo.clicks;
    self.comments = agentInfo.comments;
    self.commissions = agentInfo.commissions;
    self.community = agentInfo.community;
    self.company = agentInfo.company;
    self.created_at = agentInfo.created_at;
    self.customers = agentInfo.customers;
    self.district = agentInfo.district;
    self.followers = agentInfo.followers;
    self.label = agentInfo.label;
    self.mobile = agentInfo.mobile;
    self.name = agentInfo.name;
    self.percentile = agentInfo.percentile;
    self.position = agentInfo.position;
    self.rates = agentInfo.rates;
    self.region = agentInfo.region;
    self.rents = agentInfo.rents;
    self.sales = agentInfo.sales;
    self.stars = agentInfo.stars;
    self.transactions = agentInfo.transactions;
    self.tx = agentInfo.tx;
    self.updated_at = agentInfo.updated_at;
    self.user_id = agentInfo.user_id;
    self.visits = agentInfo.visits;

}
@end
