//
//  EHHouseDetailViewController.h
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHousesInfo.h"
#import "EHAgentInfo.h"

@interface EHHouseDetailViewController : UITableViewController

@property (nonatomic,strong) EHHousesInfo *houseInfo;
@property (nonatomic,strong) EHAgentInfo *agentInfo;

@end
