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
    [backItem setWidth:-15];
    [backItem setTintColor: RGB(68, 180, 244)];
    return backItem;
}

@end
