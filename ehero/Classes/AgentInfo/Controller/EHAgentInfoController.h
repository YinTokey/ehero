//
//  EHAgentInfoController.h
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EHAgentInfo;
@interface EHAgentInfoController : UITableViewController

@property(nonatomic,strong) EHAgentInfo *agentInfo;
@property (nonatomic,assign) BOOL reloadFlag;

@end
