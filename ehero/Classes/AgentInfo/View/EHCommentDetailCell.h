//
//  EHCommentDetailCell.h
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EHCommentFrame;

@interface EHCommentDetailCell : UITableViewCell

@property (nonatomic,strong) EHCommentFrame *commentFrame;

+ (instancetype)commentDetailCellCellWithTableView:(UITableView *)tableView;



@end
