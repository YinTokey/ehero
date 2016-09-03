//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        [self addSubview:self.titleLable];
    }
    
    return self;
}

- (UILabel *)titleLable{
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, self.bounds.size.width/2, 8)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        //_titleLable.font = [UIFont systemFontOfSize:13];
    }
    return _titleLable;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, self.bounds.size.width, self.bounds.size.height - 15)];
        _mainImageView.userInteractionEnabled = YES;
 
    }
    return _mainImageView;
}


- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

@end
