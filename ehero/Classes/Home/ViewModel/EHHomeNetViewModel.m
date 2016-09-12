//
//  EHHomeNetViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeNetViewModel.h"
#import "EHSlides.h"
#import <MJExtension.h>


@implementation EHHomeNetViewModel

- (void)getSlidesWithSourceArr:(NSMutableArray *)sourceArr
                      titleArr:(NSMutableArray *)titleArr
                     superView:(UIView *)superView
                       success:(void(^)())success
                       failure:(void(^)())failure
{
    [MBProgressHUD showMessage:@"正在加载图片" toView:superView];
    [YTHttpTool get:slidesUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
       // [MBProgressHUD hideHUDForView:superView];
        //数据处理
        NSArray *responseArray = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        _slidesArray = [EHSlides mj_objectArrayWithKeyValuesArray:responseArray];
        NSLog(@"%ld",_slidesArray.count);
        for (EHSlides *slide in _slidesArray) {
            [sourceArr addObject:slide.image];
            [titleArr addObject:slide.title];
        }
        success();
      //  [self setupHeaderView];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:superView];
        failure();
        NSLog(@"failed");
    }];
}

@end
