//
//  EHSkimedAgentViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSkimedAgentViewModel.h"
#import "EHSkimedAgentInfo.h"


@implementation EHSkimedAgentViewModel

- (void)skimedAndSaveWithAgentInfo:(EHAgentInfo *)agentInfo{
    EHSkimedAgentInfo *skimedAgent = [[EHSkimedAgentInfo alloc]init];
    [skimedAgent setWithAgentInfoAndTimeLabel:agentInfo];
    
    NSString *sqlForName = [NSString stringWithFormat:@" WHERE name = '%@' ",agentInfo.name];
    EHSkimedAgentInfo *skimedAgentExisted = [EHSkimedAgentInfo findFirstByCriteria:sqlForName];
    
    //小于30条记录
    if ([EHSkimedAgentInfo findCounts] < 30) {
        //数据库里没有,直接插入
        if (skimedAgentExisted == nil) {
            NSLog(@"数据库里没有,直接插入");
            [skimedAgent save];
            //数据库里有
        }else{
            NSLog(@"数据库里有,先删再插");
            [skimedAgentExisted deleteObject];
            [skimedAgent save];
        }
        
    }
    //大于等于30条记录
    else{
        //大于30条里，数据库里没有
        if (skimedAgentExisted == nil) {
            NSLog(@"大于等于30条里，数据库里没有,删除第一条");
            NSString *sqlForName = [NSString stringWithFormat:@" LIMIT 1 OFFSET 0 "];
            [[EHSkimedAgentInfo findFirstByCriteria:sqlForName] deleteObject];;
            [skimedAgent save];
            
        }else{
            //大于30条里，数据库里有
            NSLog(@"大于30条里，数据库里有,删除原来的，重新插入");
            [skimedAgentExisted deleteObject];
            [skimedAgent save];
        }
        
    }



}

@end
