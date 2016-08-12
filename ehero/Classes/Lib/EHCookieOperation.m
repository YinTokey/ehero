//
//  EHCookieOperation.m
//  ehero
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCookieOperation.h"

@implementation EHCookieOperation

+ (void)saveCookie{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
    NSHTTPCookie *cookie = [cookies objectAtIndex:0];
    NSData *cookieData = [NSKeyedArchiver archivedDataWithRootObject:cookie];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cookieData forKey:@"cookie"];
}

+ (BOOL)setCookie{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSHTTPCookie *cookie = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    //如果有cookie,则设置cookie
    if (cookie) {
   
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        [cookieStorage setCookie:cookie];
        NSLog(@"setCookie %@",cookie);
        return YES;
    }else{
        NSLog(@"no cookie");
        return NO;
    }
    
}

@end
