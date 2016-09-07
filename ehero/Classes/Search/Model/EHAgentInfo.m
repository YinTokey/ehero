//
//  EHAgentInfo.m
//  ehero
//
//  Created by Mac on 16/7/13.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfo.h"

@implementation EHAgentInfo

- (void)getIdStringFromDictionary{
    NSDictionary *idDic = self._id;
    self.idStr = [idDic objectForKey:@"$oid"];
}
#pragma mark - 计算百分比
- (NSArray *)percentageWithMaxValue:(EHAverageInfo *)averageInfo{
    if ([self.company isEqualToString:@"链家"]) {
        NSNumber *commissions_percentage = [NSNumber numberWithFloat:(_commissions /averageInfo.lianjia_commissions_max)];
        NSNumber *transactions_percentage = [NSNumber numberWithFloat:(_transactions /averageInfo.lianjia_transactions_max)];
        NSNumber *visits_percentage = [NSNumber numberWithFloat:(_visits /averageInfo.lianjia_visits_max)];
        NSNumber *rates_percentage = [NSNumber numberWithFloat:(_rates /averageInfo.lianjia_rates_max)];
        NSNumber *reviews_percentage = [NSNumber numberWithFloat:(_reviews /averageInfo.lianjia_reviews_max)];
        NSArray *array = @[commissions_percentage,
                           transactions_percentage,
                           visits_percentage,
                           rates_percentage,
                           reviews_percentage];
        
        return array;
    }else if([self.company isEqualToString:@"我爱我家"]){
        NSNumber *sales_percentage = [NSNumber numberWithFloat:(_sales /averageInfo.wawj_sales_max)];
        NSNumber *rents_percentage = [NSNumber numberWithFloat:(_rents /averageInfo.wawj_rents_max)];
        NSNumber *followers_percentage = [NSNumber numberWithFloat:(_followers /averageInfo.wawj_followers_max)];
        NSNumber *rates_percentage = [NSNumber numberWithFloat:(_rates /averageInfo.wawj_rates_max)];
        NSNumber *clicks_percentage = [NSNumber numberWithFloat:(_clicks /averageInfo.wawj_clicks_max)];
        NSArray *array = @[sales_percentage,
                           rents_percentage,
                           followers_percentage,
                           rates_percentage,
                           clicks_percentage];
        return array;
    }else{  //麦田比例比较小，乘以2
        NSNumber *sales_percentage = [NSNumber numberWithFloat:(_sales /averageInfo.maitian_sales_max)*2];
        NSNumber *rents_percentage = [NSNumber numberWithFloat:(_rents /averageInfo.maitian_rents_max)*2];
        NSNumber *followers_percentage = [NSNumber numberWithFloat:(_followers /averageInfo.maitian_followers_max)*2];
        NSNumber *customers_percentage = [NSNumber numberWithFloat:(_customers /averageInfo.maitian_customers_max)*2];
        NSNumber *commissions_percentage = [NSNumber numberWithFloat:(_commissions /averageInfo.maitian_commissions_max)*2];
        NSArray *array = @[sales_percentage,
                           rents_percentage,
                           followers_percentage,
                           customers_percentage,
                           commissions_percentage];
        return array;
    }
    
}

@end
