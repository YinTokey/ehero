//
//  AppDelegate.h
//  ehero
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property float autoSizeScaleX;
@property float autoSizeScaleY;

//兼容函数(storyboard)
+ (void)storyBoradAutoLay:(UIView *)allView;

@end

