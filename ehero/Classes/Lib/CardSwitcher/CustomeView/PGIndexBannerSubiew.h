//
//  PGIndexBannerSubiew.h
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

/******************************
 
 可以根据自己的需要再次重写view
 
 ******************************/

#import <UIKit/UIKit.h>

@interface PGIndexBannerSubiew : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

/**
 *  标题
 */
//@property (nonatomic, strong) UILabel *titleLable;

/**
 *  主图
 */
//@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@end
