//
//  EHNavBackItem.m
//  ehero
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHNavBackItem.h"

@implementation EHNavBackItem

+ (instancetype)setBackTitle:(NSString *)title{
    EHNavBackItem *backItem = [[EHNavBackItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    return backItem;
}

@end
