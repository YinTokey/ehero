//
//  EHCommentDetailCell.h
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHCommunityButton.h"
@class EHCommentFrame;

@interface EHCommentDetailCell : UITableViewCell

@property (nonatomic,strong) EHCommentFrame *commentFrame;

@property (nonatomic, weak) UILabel *author;
@property (nonatomic, weak) UIButton *starBtn;
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) EHCommunityButton *communityBtn;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIImageView *background;

+ (instancetype)commentDetailCellCellWithTableView:(UITableView *)tableView;



@end
