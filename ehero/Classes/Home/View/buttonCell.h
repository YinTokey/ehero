//
//  buttonCell.h
//  ehero
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol buttonCellDelegate <NSObject>
//1.声明代理方法
- (void)firstBtnClick:(UITableViewCell *)cell;
- (void)secondBtnClick:(UITableViewCell *)cell;
- (void)thirdBtnClick:(UITableViewCell *)cell;
- (void)fourthBtnClick:(UITableViewCell *)cell;



@end

@interface buttonCell : UITableViewCell

+ (instancetype)buttonCellWithTableView:(UITableView *)tableView;
//2.声明代理属性
@property (nonatomic,weak)id<buttonCellDelegate> delegate;


- (void)setClickEvent;
@end
