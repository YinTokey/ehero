//
//  EHLabel.m
//  易房好介
//
//  Created by Mac on 16/9/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHLabel.h"
#import "UILabel+GetWidth.h"
@implementation EHLabel

+ (instancetype)LabelWithText:(NSString *)text{
    EHLabel *regionLabel = [[EHLabel alloc]init];
    regionLabel.textAlignment = NSTextAlignmentCenter;
    regionLabel.font = [UIFont systemFontOfSize:12.0];
    regionLabel.textColor = [UIColor whiteColor];
    regionLabel.backgroundColor = RGB(68, 180, 244);
    regionLabel.text = text;
    regionLabel.textWidth = [UILabel getWidthWithTitle:regionLabel.text font:[UIFont systemFontOfSize:12.0]];
    
    return regionLabel;
}

@end
