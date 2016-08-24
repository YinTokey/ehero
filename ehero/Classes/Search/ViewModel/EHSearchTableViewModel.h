//
//  EHSearchTableViewModel.h
//  ehero
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EHSearchTableViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *searchResultArr;

# pragma mark - 搜索方法
- (void)searchWithURLString:(NSString *)urlString Param:(NSDictionary *)param;

@end
