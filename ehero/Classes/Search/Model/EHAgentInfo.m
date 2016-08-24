//
//  EHAgentInfo.m
//  ehero
//
//  Created by Mac on 16/7/13.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfo.h"

@implementation EHAgentInfo

//+ (instancetype)setWithAgentInfoController:(EHAgentInfoController *)AgentInfoController{
//    EHAgentInfo *agentInfo = [[EHAgentInfo alloc]init];
//    agentInfo.idStr = AgentInfoController.idStr;
//    agentInfo.name = AgentInfoController.name;
//    agentInfo.tx = AgentInfoController.tx;
//    agentInfo.position = AgentInfoController.position;
//    agentInfo.company = AgentInfoController.company;
//    agentInfo.region = AgentInfoController.region;
//    agentInfo.rates = AgentInfoController.rates;
//    agentInfo.community = AgentInfoController.community;
//
//    return agentInfo;
//
//}

//- (id)init{
//    self = [super init];
//    if (self) {
//        NSDictionary *idDic = self._id;
//        self.idStr = [idDic objectForKey:@"$oid"];
//    }
//    return self;
//
//}

- (void)getIdStringFromDictionary{
    NSDictionary *idDic = self._id;
    self.idStr = [idDic objectForKey:@"$oid"];
}

@end
