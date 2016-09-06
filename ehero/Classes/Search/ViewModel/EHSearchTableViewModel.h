//
//  EHSearchTableViewModel.h
//  ehero
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EHAgentInfo.h"

@interface EHSearchTableViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *searchResultArr;

@property (nonatomic,strong) EHAgentInfo *agentInfo;

@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@property (nonatomic,strong) UIViewController *superVC;

# pragma mark - 搜索方法
- (void)searchWithURLString:(NSString *)urlString Param:(NSDictionary *)param;


//-(void)agentInfoVCWithIndexPath:(NSIndexPath *)indexPath WithViewController:(UIViewController *)superController;

@end
