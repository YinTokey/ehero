//
//  EHStorageViewModel.m
//  ehero
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHStorageViewModel.h"

@implementation EHStorageViewModel

- (void)storeCode:(NSString *)code{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *systemDate = [NSDate date];
    NSDictionary *codeDic = @{@"date":systemDate,
                              @"code":code};
    
    [defaults setObject:codeDic forKey:@"codeDic"];
    [defaults synchronize];
}

@end
