//
//  EHSiteSelectDelegate.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EHHomePopView.h"
@interface EHSiteSelectDelegate : NSObject<selectIndexPathDelegate>

- (void)readDefaults;
- (void)selectIndexPathRow:(NSInteger)index;

@property (nonatomic,strong) UIButton *siteButton;
@property (nonatomic,copy) NSString *siteString;


@end
