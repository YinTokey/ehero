//
//  ShareView.h
//  PPSpringShareView
//
//  Created by macfai on 16/2/23.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^shareBlock)(NSInteger index);

@interface ShareView : UIView

@property(nonatomic,copy)shareBlock block;

///初始化
-(id)initWithTitleArray:(NSMutableArray *)titleArray picArray:(NSMutableArray *)picArray;

///视图展示
-(void)showShareView;

///当前选中索引

-(void)currentIndexWasSelected:(shareBlock)block;


@end
