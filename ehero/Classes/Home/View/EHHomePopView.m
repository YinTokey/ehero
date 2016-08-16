//
//  EHHomePopView.m
//  ehero
//
//  Created by Mac on 16/8/16.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomePopView.h"

@implementation EHHomePopView

+ (instancetype)initPopView:(UIButton *)superButton SuperView:(UIView *)superView{

    CGPoint point = CGPointMake(superButton.center.x,superButton.center.y + 45);
    EHHomePopView *popView = [[EHHomePopView alloc] initWithOrigin:point Width:80 Height:40 * 4 Type:XTTypeOfUpCenter Color:[UIColor whiteColor] superView:superView];
    popView.dataArray = @[@"北京",@"上海",@"广州", @"深圳"];
    popView.fontSize = 13;
    popView.row_height = 40;
    popView.titleTextColor = [UIColor blackColor];
    return popView;
}

@end
