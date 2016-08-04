//
//  EHTipsNavBottomLine.m
//  ehero
//
//  Created by Mac on 16/7/26.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsNavBottomLine.h"

@implementation EHTipsNavBottomLine

+ (instancetype)initNavBottomLineWithController:(UIViewController *)viewController{
    EHTipsNavBottomLine *lineView = [[EHTipsNavBottomLine alloc]initWithFrame:CGRectMake(0, viewController.navigationController.navigationBar.frame.size.height, viewController.view.frame.size.width, 1)];
    [lineView setBackgroundColor:RGB(67, 179, 241)];
    return lineView;
}

@end
