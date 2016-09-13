//
//  EHCommentAgentViewController.h
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHAgentInfo.h"
@interface EHCommentAgentViewController : UIViewController

@property (nonatomic,strong)EHAgentInfo *agentInfo;

- (void)storeCode:(NSString *)code;



@end

