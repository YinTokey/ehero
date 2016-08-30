//
//  EHHomeNetViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHHomeNetViewModel : NSObject

@property (nonatomic,strong)NSMutableArray *slidesArray;


- (void)getSlidesWithSourceArr:(NSMutableArray *)sourceArr
                      titleArr:(NSMutableArray *)titleArr
                     superView:(UIView *)superView
                       success:(void(^)())success
                       failure:(void(^)())failure;

@end
