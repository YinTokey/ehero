//
//  EHCommentAgentNetViewModel.h
//  ehero
//
//  Created by Mac on 16/8/29.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHCommentAgentNetViewModel : NSObject
- (void)submitWithText:(NSString *)text
                  Kind:(NSString *)commentKind
                 idStr:(NSString *)idStr
             superView:(UIView *)superView;
@end
