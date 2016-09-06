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
    self.author = agentInfo.author;
    self.career = agentInfo.career;
    self.city = agentInfo.city;
    self.clicks = agentInfo.clicks;
    self.comments = agentInfo.comments;
    self.commissions = agentInfo.commissions;
    self.community = agentInfo.community;
    self.company = agentInfo.company;
    self.content = agentInfo.content;
    self.created_at = agentInfo.created_at;
    self.customers = agentInfo.customers;
    self.district = agentInfo.district;
    self.followers = agentInfo.followers;
    self.href = agentInfo.href;
    self.label = agentInfo.label;
    self.major = agentInfo.major;
    self.mobile = agentInfo.mobile;
    self.name = agentInfo.name;
    self.money = agentInfo.money;
    self.percentile = agentInfo.percentile;
    self.position = agentInfo.position;
    self.rates = agentInfo.rates;
    self.region = agentInfo.region;
    self.rents = agentInfo.rents;
    self.reviews = agentInfo.reviews;
    self.sales = agentInfo.sales;
    self.stars = agentInfo.stars;
    self.transactions = agentInfo.transactions;
    self.tx = agentInfo.tx;
    self.updated_at = agentInfo.updated_at;
    self.user_id = agentInfo.user_id;
    self.visits = agentInfo.visits;

}

- (EHAgentInfo *)toAgentInfo{
    EHAgentInfo *agentInfo = [[EHAgentInfo alloc]init];
    agentInfo._id = self._id;
    agentInfo.idStr = self.idStr;
    agentInfo._slugs = self._slugs;
    agentInfo.author = self.author;
    agentInfo.career = self.career;
    agentInfo.city = self.city;
    agentInfo.clicks = self.clicks;
    agentInfo.comments = self.comments;
    agentInfo.commissions = self.commissions;
    agentInfo.community = self.community;
    agentInfo.company = self.company;
    agentInfo.content = self.content;
    agentInfo.created_at = self.created_at;
    agentInfo.customers = self.customers;
    agentInfo.district = self.district;
    agentInfo.followers = self.followers;
    agentInfo.href = self.href;
    agentInfo.label = self.label;
    agentInfo.major = self.major;
    agentInfo.mobile = self.mobile;
    agentInfo.name = self.name;
    agentInfo.money = self.money;
    agentInfo.percentile = self.percentile;
    agentInfo.position = self.position;
    agentInfo.rates = self.rates;
    agentInfo.region = self.region;
    agentInfo.rents = self.rents;
    agentInfo.reviews = self.reviews;
    agentInfo.sales = self.sales;
    agentInfo.stars = self.stars;
    agentInfo.transactions = self.transactions;
    agentInfo.tx = self.tx;
    agentInfo.updated_at = self.updated_at;
    agentInfo.user_id = self.user_id;
    agentInfo.visits = self.visits;

    return agentInfo;
}
@end
