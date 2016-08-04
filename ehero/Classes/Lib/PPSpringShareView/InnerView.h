//
//  InnerView.h
//  PPSpringShareView
//
//  Created by macfai on 16/2/23.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>


///传值被点击的按钮的索引

typedef void (^PPBlock)(NSInteger index);


@interface InnerView : UIView


@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)PPBlock block;


-(void)selectedCurrentIndex:(PPBlock)block;

@end
