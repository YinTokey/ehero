//
//  EHHouseSourcesMessage.m
//  ehero
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseSourcesMessage.h"

@implementation EHHouseSourcesMessage
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.textId = [[dict objectForKey:@"textId"]intValue];
        self.textContent = [dict objectForKey:@"textContent"];
        self.isShowMoreText = NO;
    }
    return self;
}
@end
