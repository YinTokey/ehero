//
//  EHCommentDetailCell.m
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentDetailCell.h"
#import "EHCommentInfo.h"
#import "EHCommentFrame.h"
#import "UIImage+Extensiton.h"
#import "EHCommunityButton.h"
@interface EHCommentDetailCell ()

@property (nonatomic, weak) UILabel *mobile;
@property (nonatomic, weak) UIButton *starBtn;
@property (nonatomic, weak) UIButton *textView;
@property (nonatomic, weak) EHCommunityButton *communityBtn;
@property (nonatomic, weak) UILabel *timeLabel;


@end


@implementation EHCommentDetailCell

+ (instancetype)commentDetailCellCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"commentDetailCell";
    EHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[EHCommentDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

//2 创建子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        // 电话
        UILabel *mobile = [[UILabel alloc]init];
        [self.contentView addSubview:mobile];
        mobile.textAlignment = NSTextAlignmentCenter;
        // 点赞按钮
        UIButton *starBtn = [[UIButton alloc]init];
        [self.contentView addSubview:starBtn];
        self.starBtn = starBtn;
        // 评论内容
        UIButton *textView = [[UIButton alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        //设置字体大小
        textView.titleLabel.font = [UIFont systemFontOfSize:13];
        //设置换行
        textView.titleLabel.numberOfLines = 0;
        //设置字体的颜色
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置按钮中内容的边距
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        // 小区
        EHCommunityButton *communityBtn = [[EHCommunityButton alloc]init];
        [self.contentView addSubview:communityBtn];
        self.communityBtn = communityBtn;
        // 提交评论时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
    }
    return self;
}

- (void)setCommentFrame:(EHCommentFrame *)commentFrame{
    _commentFrame = commentFrame;
    EHCommentInfo *commentInfo = commentFrame.commentInfo;
    //评论作者名字 就是电话
    self.mobile.text = commentInfo.author;

    //内容
    [self.textView setTitle:commentInfo.text forState:UIControlStateNormal];
    
    //设置消息背景图片
    [self.textView setBackgroundImage:[UIImage resizeImage:@"comment_background"] forState:UIControlStateNormal];
    
    self.mobile.frame = commentFrame.mobileFrame;
    self.textView.frame = commentFrame.textFrame;
    
    
    
}

@end