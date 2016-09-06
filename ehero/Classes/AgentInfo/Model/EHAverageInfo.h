//
//  EHAverageInfo.h
//  易房好介
//
//  Created by Mac on 16/9/6.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHAverageInfo : NSObject
/**
 *  成交量
 */
@property (nonatomic,assign) CGFloat lianjia_commissions_max;
/**
 *  委托量
 */
@property (nonatomic,assign) CGFloat lianjia_transactions_max;
/**
 *  带看量
 */
@property (nonatomic,assign) CGFloat lianjia_visits_max;
/**
 *  好评率
 */
@property (nonatomic,assign) CGFloat lianjia_rates_max;
/**
 *  评论数量
 */
@property (nonatomic,assign) CGFloat lianjia_reviews_max;

@property (nonatomic,assign) CGFloat lianjia_commissions_avg;

@property (nonatomic,assign) CGFloat lianjia_transactions_avg;

@property (nonatomic,assign) CGFloat lianjia_visits_avg;

@property (nonatomic,assign) CGFloat lianjia_rates_avg;

@property (nonatomic,assign) CGFloat lianjia_reviews_avg;
/**
 *  售
 */
@property (nonatomic,assign) CGFloat wawj_sales_max;
/**
 *  租
 */
@property (nonatomic,assign) CGFloat wawj_rents_max;
/**
 * 关注量
 */
@property (nonatomic,assign) CGFloat wawj_followers_max;
/**
 *  好评率
 */
@property (nonatomic,assign) CGFloat wawj_rates_max;
/**
 *  浏览量
 */
@property (nonatomic,assign) CGFloat wawj_clicks_max;

@property (nonatomic,assign) CGFloat wawj_sales_avg;

@property (nonatomic,assign) CGFloat wawj_rents_avg;

@property (nonatomic,assign) CGFloat wawj_followers_avg;

@property (nonatomic,assign) CGFloat wawj_rates_avg;

@property (nonatomic,assign) CGFloat wawj_clicks_avg;
/**
 *  在售
 */
@property (nonatomic,assign) CGFloat maitian_sales_max;
/**
 *  在租
 */
@property (nonatomic,assign) CGFloat maitian_rents_max;
/**
 *  粉丝数量
 */
@property (nonatomic,assign) CGFloat maitian_followers_max;
/**
 *  服务客户数
 */
@property (nonatomic,assign) CGFloat maitian_customers_max;
/**
 *  近期成交量
 */
@property (nonatomic,assign) CGFloat maitian_commissions_max;

@property (nonatomic,assign) CGFloat maitian_sales_avg;

@property (nonatomic,assign) CGFloat maitian_rents_avg;

@property (nonatomic,assign) CGFloat maitian_followers_avg;

@property (nonatomic,assign) CGFloat maitian_customers_avg;

@property (nonatomic,assign) CGFloat maitian_commissions_avg;


- (NSArray *)percentOfLianjia;
- (NSArray *)percentOfWawj;
- (NSArray *)percentOfMaitian;

@end
