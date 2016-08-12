//
//  EHRegularExpression.m
//  ehero
//
//  Created by Mac on 16/8/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHRegularExpression.h"

@implementation EHRegularExpression

+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

@end
