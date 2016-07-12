//
//  EHNewsViewCell.m
//  ehero
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHNewsViewCell.h"

@implementation EHNewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置cell圆角
    [self.layer setCornerRadius:2.0];
}

@end
