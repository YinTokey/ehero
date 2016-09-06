//
//  EHAgentInfoNetViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHAverageInfo.h"

@interface EHAgentInfoNetViewModel : NSObject

- (void)callAgentWithIdStr:(NSString *)idStr code:(NSString *)code failure:(void (^)())failure;

- (void)getAverageInfo;

@end
