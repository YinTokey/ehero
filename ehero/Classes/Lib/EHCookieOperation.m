//
//  EHCookieOperation.m
//  ehero
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCookieOperation.h"

@implementation EHCookieOperation
//cookie  date 存字典里
+ (void)saveCookieWithDate:(NSDate *)date{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
    NSHTTPCookie *cookie = [cookies objectAtIndex:0];
    NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:cookie];
    NSDictionary *cookieDictionary = @{@"cookie":cookieData,
                                       @"date":date};
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cookieDictionary forKey:@"cookieDictionary"];
}

+ (BOOL)setCookie{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *cookieDictionary = [userDefaults objectForKey:@"cookieDictionary"];

    //如果有cookie,则设置比较时间，条件满足24小时内再设置cookie,否则也是返回 NO
    if (cookieDictionary) {
        NSData *cookieData = [cookieDictionary objectForKey:@"cookie"];
        NSDate *date = [cookieDictionary objectForKey:@"date"];
        //获取系统时间来互相比较
        NSDate *systemDate = [NSDate date];
        NSTimeInterval interval = [systemDate timeIntervalSinceDate:date];
        NSInteger resultInterval = ((NSInteger)interval);
        if (resultInterval <= 24*3600) {
            NSLog(@"interval %d s",resultInterval);
            NSHTTPCookie *cookie = [NSKeyedUnarchiver unarchiveObjectWithData:cookieData];
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            [cookieStorage setCookie:cookie];
            NSLog(@"setCookie %@",cookie);
            return YES;
        }else{
        
            return NO;
        }

    }else{
        NSLog(@"no cookie");
        return NO;
    }
    
}

@end
