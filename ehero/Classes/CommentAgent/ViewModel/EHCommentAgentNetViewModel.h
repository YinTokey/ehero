//
//  EHCommentAgentNetViewModel.h
//  ehero
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHCommentAgentNetViewModel : NSObject

@property (nonatomic,strong) NSMutableArray *searchResultArr;

- (void)submitWithText:(NSString *)text
                  Kind:(NSString *)commentKind
                 idStr:(NSString *)idStr
             community:(NSString *)community
               superVC:(UIViewController *)superVC;

- (void)searchWithURLString:(NSString *)urlString
                      Param:(NSDictionary *)param
                  superView:(UIView *)superView
                    success:(void(^)())success
                    failure:(void(^)())failure;

@end
