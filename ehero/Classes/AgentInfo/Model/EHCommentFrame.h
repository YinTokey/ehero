//
//  EHCommentFrame.h
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EHCommentInfo;

@interface EHCommentFrame : NSObject

@property (nonatomic, assign, readonly) CGRect authorFrame;
@property (nonatomic, assign, readonly) CGRect starFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGRect communityFrame;
@property (nonatomic, assign, readonly) CGRect timeFrame;

/**
 *  行高
 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;
/**
 *  模型对象
 */
@property (nonatomic, strong) EHCommentInfo *commentInfo;

@end
