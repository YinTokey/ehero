//
//  EHAgentInfoNetViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHAverageInfo.h"
#import "EHAgentInfo.h"

@interface EHAgentInfoNetViewModel : NSObject

@property (nonatomic,strong) UIViewController *superVC;

- (void)callAgentWithIdStr:(NSString *)idStr
                      code:(NSString *)code
                   success:(void(^)())success
                   failure:(void (^)())failure;

- (void)getAverageInfo:(void(^)(EHAverageInfo *averageInfo))success;

- (void)getAgentInfo:(NSString *)name
             success:(void(^)(NSArray *resultArray))success
             failure:(void(^)())failure;

@end
