

//
//  InnerView.m
//  PPSpringShareView
//
//  Created by macfai on 16/2/23.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import "InnerView.h"

@implementation InnerView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.button.backgroundColor = [UIColor clearColor];
        self.button.layer.cornerRadius = 5.0;
        self.button.layer.masksToBounds = YES;
        [self.button setCenter:CGPointMake(self.frame.size.width/2, 30)];
        [self.button addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.frame.size.width, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

-(void)shareBtnClicked:(UIButton *)btn{
    
    self.block(self.button.tag);
    
}

-(void)selectedCurrentIndex:(PPBlock)block{
    self.block = block;
}

@end
