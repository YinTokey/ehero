//
//  EHCommunityButton.m
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommunityButton.h"
#import "UIButton+GetWidth.h"
@implementation EHCommunityButton

+ (instancetype)communityButton:(NSString *)title{
    EHCommunityButton *comBtn = [[EHCommunityButton alloc]init];

    [comBtn setBackgroundImage:[UIImage imageNamed:@"community_background"] forState:UIControlStateNormal];
    [comBtn setTitleColor:RGB(164, 223, 251) forState:UIControlStateNormal];
    comBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [comBtn setTitle:title forState:UIControlStateNormal];
    comBtn.realWidth = [UIButton getWidthWithTitle:comBtn.titleLabel.text font:comBtn.titleLabel.font];
    comBtn.userInteractionEnabled = NO;
    return comBtn;
}




@end
