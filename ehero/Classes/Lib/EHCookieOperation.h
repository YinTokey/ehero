//
//  EHCookieOperation.h
//  ehero
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHCookieOperation : NSObject

+ (void)saveCookieWithDate:(NSDate *)date;

+ (BOOL)setCookie;

@end
