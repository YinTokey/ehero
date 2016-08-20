//
//  EHHouseSourcesMessage.h
//  ehero
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHHouseSourcesMessage : NSObject

@property(nonatomic, assign)int       textId;
@property(nonatomic, strong)NSString  *textContent;
///是否展开状态，默认No
@property(nonatomic, assign)BOOL      isShowMoreText;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
