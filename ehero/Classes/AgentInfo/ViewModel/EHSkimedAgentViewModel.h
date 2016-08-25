//
//  EHSkimedAgentViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHAgentInfo.h"
@interface EHSkimedAgentViewModel : NSObject

- (void)skimedAndSaveWithAgentInfo:(EHAgentInfo *)agentInfo;

@end
