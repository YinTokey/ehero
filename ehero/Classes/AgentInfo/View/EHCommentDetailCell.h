//
//  EHCommentDetailCell.h
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHCommunityButton.h"
#import "EHCommentInfo.h"


@interface EHCommentDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (nonatomic,strong) EHCommentInfo *commentInfo;

//@property (nonatomic,strong) EHCommentFrame *commentFrame;
//
//@property (nonatomic, weak) UILabel *author;
//@property (nonatomic, weak) UIButton *starBtn;
//@property (nonatomic, weak) UITextView *textView;
//@property (nonatomic, weak) EHCommunityButton *communityBtn;
//@property (nonatomic, weak) UILabel *timeLabel;
//@property (nonatomic, weak) UIImageView *background;

+ (instancetype)commentDetailCellCellWithTableView:(UITableView *)tableView;

@property (nonatomic,assign) CGRect rect;

@end
