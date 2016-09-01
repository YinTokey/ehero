//
//  EHTipsRecommend.m
//  ehero
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsRecommend.h"

@implementation EHTipsRecommend

- (void)getIdStringFromDictionary{
    NSDictionary *idDic = self._id;
    self.idStr = [idDic objectForKey:@"$oid"];
}

@end
