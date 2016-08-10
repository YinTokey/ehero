//
//  EHCommunityLabel.m
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommunityLabel.h"
#import "UILabel+GetWidth.h"
@implementation EHCommunityLabel

+ (instancetype)communityLabel{
    EHCommunityLabel *communityLabel = [[EHCommunityLabel alloc]init];
    CGFloat width = [UILabel getWidthWithTitle:communityLabel.text font:communityLabel.font];

    communityLabel.font =  [UIFont fontWithName:@"Arial-BoldItalicMT" size:13];
    UIColor *colorImg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"community_background"]];
    [communityLabel setBackgroundColor:colorImg];
    communityLabel.frame = CGRectMake(30, 40, width, 30);

    return communityLabel;
}


@end
