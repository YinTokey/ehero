//
//  EHSiteSelectDelegate.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSiteSelectDelegate.h"

@implementation EHSiteSelectDelegate

- (void)readDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *siteString = [defaults objectForKey:@"siteString"];
    if (siteString.length > 1) {
        [self.siteButton setTitle:siteString forState:UIControlStateNormal];
    }
}
#pragma mark - 实现代理方法，左上角弹窗点击事件
- (void)selectIndexPathRow:(NSInteger)index{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (index) {
        case 0:
        {
            self.siteString = @"北京";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteButton setTitle:_siteString forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            self.siteString = @"上海";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteButton setTitle:_siteString forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.siteString = @"广州";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteButton setTitle:_siteString forState:UIControlStateNormal];
        }
            break;
        case 3:
        {
            self.siteString = @"深圳";
            [defaults setObject:_siteString forKey:@"siteString"];
            [self.siteButton setTitle:_siteString forState:UIControlStateNormal];
        }
        default:
            break;
    }
}

@end
