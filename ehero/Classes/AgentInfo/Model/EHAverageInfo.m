//
//  EHAverageInfo.m
//  易房好介
//
//  Created by Mac on 16/9/6.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAverageInfo.h"

@implementation EHAverageInfo

- (NSArray *)percentOfLianjia{
    NSNumber *lianjia_commissions_percentage = [NSNumber numberWithFloat:(_lianjia_commissions_avg / _lianjia_commissions_max)];
    NSNumber *lianjia_transactions_percentage = [NSNumber numberWithFloat: (_lianjia_transactions_avg / _lianjia_transactions_max)];
    NSNumber *lianjia_visits_percentage = [NSNumber numberWithFloat:( _lianjia_visits_avg / _lianjia_visits_max)];
    NSNumber *lianjia_rates_percentage = [NSNumber numberWithFloat:( _lianjia_rates_avg / _lianjia_rates_max)];
    NSNumber *lianjia_reviews_percentage = [NSNumber numberWithFloat:(_lianjia_reviews_avg / _lianjia_reviews_max)];
    
    NSArray *array = @[lianjia_commissions_percentage,
                       lianjia_transactions_percentage,
                       lianjia_visits_percentage,
                       lianjia_rates_percentage,
                       lianjia_reviews_percentage];
    return array;
}

- (NSArray *)percentOfWawj{
    NSNumber *wawj_sales_percentage = [NSNumber numberWithFloat:(_wawj_sales_avg / _wawj_sales_max)];
    NSNumber *wawj_rents_percentage = [NSNumber numberWithFloat: (_wawj_rents_avg / _wawj_rents_max)];
    NSNumber *wawj_followers_percentage = [NSNumber numberWithFloat:(_wawj_followers_avg / _wawj_followers_max)];
    NSNumber *wawj_rates_percentage = [NSNumber numberWithFloat:(_wawj_rates_avg / _wawj_rates_max)];
    NSNumber *wawj_clicks_percentage = [NSNumber numberWithFloat:(_wawj_clicks_avg / _wawj_clicks_max)];
    
    NSArray *array = @[wawj_sales_percentage,
                       wawj_rents_percentage,
                       wawj_followers_percentage,
                       wawj_rates_percentage,
                       wawj_clicks_percentage];
    return array;
}

- (NSArray *)percentOfMaitian{
    NSNumber *maitian_sales_percentage = [NSNumber numberWithFloat:(_maitian_sales_avg / _maitian_sales_max)];
    NSNumber *maitian_rents_percentage = [NSNumber numberWithFloat: (_maitian_rents_avg / _maitian_rents_max)];
    NSNumber *maitian_followers_percentage = [NSNumber numberWithFloat:(_maitian_followers_avg / _maitian_followers_max)];
    NSNumber *maitian_customers_percentage = [NSNumber numberWithFloat:(_maitian_customers_avg / _maitian_customers_max)];
    NSNumber *maitian_commissions_percentage = [NSNumber numberWithFloat:(_maitian_commissions_avg / _maitian_commissions_max)];
    
    NSArray *array = @[maitian_sales_percentage,
                       maitian_rents_percentage,
                       maitian_followers_percentage,
                       maitian_customers_percentage,
                       maitian_commissions_percentage];
    return array;
}

@end
