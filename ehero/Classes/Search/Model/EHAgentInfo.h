//
//  EHAgentInfo.h
//  ehero
//
//  Created by Mac on 16/7/13.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHAgentInfoController.h"


@interface EHAgentInfo : NSObject
/**
 *  id
 */
@property(nonatomic,copy)NSString *_id;
/**
 *  _slugs
 */
@property(nonatomic,copy)NSString *_slugs;
/**
 *  从业年数
 */
@property(nonatomic,copy)NSString *career;
/**
 *  城市
 */
@property(nonatomic,copy)NSString *city;
/**
 *  点击量
 */
@property(nonatomic,copy)NSString *clicks;
/**
 *  评论数量
 */
@property(nonatomic,copy)NSString *comments;
/**
 *  成交
 */
@property(nonatomic,copy)NSString *commissions;
/**
 *  小区
 */
@property(nonatomic,copy)NSString *community;
/**
 *  公司
 */
@property(nonatomic,copy)NSString *company;
/**
 *  created_at
 */
@property(nonatomic,copy)NSString *created_at;
/**
 *  顾客数量
 */
@property(nonatomic,copy)NSString *customers;
/**
 *  地区
 */
@property(nonatomic,copy)NSString *district;
/**
 *  粉丝数量
 */
@property(nonatomic,copy)NSString *followers;
/**
 *  个人标签
 */
@property(nonatomic,copy)NSString *label;
/**
 *  电话号码
 */
@property(nonatomic,copy)NSString *mobile;
/**
 *  姓名
 */
@property(nonatomic,copy)NSString *name;
/**
 *  percentile
 */
@property(nonatomic,copy)NSString *percentile;
/**
 *  职位
 */
@property(nonatomic,copy)NSString *position;
/**
 *  好评率
 */
@property(nonatomic,copy)NSString *rates;
/**
 *  板块
 */
@property(nonatomic,copy)NSString *region;
/**
 *  rents
 */
@property(nonatomic,copy)NSString *rents;
/**
 *  销售数
 */
@property(nonatomic,copy)NSString *sales;
/**
 *  点赞数
 */
@property(nonatomic,copy)NSString *stars;
/**
 *  transactions
 */
@property(nonatomic,copy)NSString *transactions;
/**
 *  头像url
 */
@property(nonatomic,copy)NSString *tx;
/**
 *  updated_at
 */
@property(nonatomic,copy)NSString *updated_at;
/**
 *  user_id
 */
@property(nonatomic,copy)NSString *user_id;
/**
 *  visits
 */
@property(nonatomic,copy)NSString *visits;

+ (instancetype)setWithAgentInfoController:(EHAgentInfoController *)AgentInfoController;


@end
