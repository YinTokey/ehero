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

@property (nonatomic, weak) UILabel *author;
@property (nonatomic, weak) UIButton *starBtn;
@property (nonatomic, weak) UIButton *textView;
@property (nonatomic, weak) EHCommunityButton *communityBtn;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIButton *backgroundBtn;

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
        //背景按钮
//        UIButton *backgroundBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height)];
//        [backgroundBtn setBackgroundImage:[UIImage resizeImage:@"comment_background"] forState:UIControlStateNormal];
//        [self.contentView addSubview:backgroundBtn];
//        self.backgroundBtn = backgroundBtn;
        

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
        textView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        textView.titleEdgeInsets = UIEdgeInsetsMake(15, 20, 10, 10);
        
        // 电话
        UILabel *mobile = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 40, 20)];
        [self.textView addSubview:mobile];
        mobile.textAlignment = NSTextAlignmentLeft;
        // 点赞按钮
        UIButton *starBtn = [[UIButton alloc]init];
        [self.textView addSubview:starBtn];
        self.starBtn = starBtn;
        
        // 小区
        EHCommunityButton *communityBtn = [[EHCommunityButton alloc]init];
        [self.textView addSubview:communityBtn];
        self.communityBtn = communityBtn;
        // 提交评论时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.textView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
    }
    return self;
}

- (void)setCommentFrame:(EHCommentFrame *)commentFrame{
    
    _commentFrame = commentFrame;
    EHCommentInfo *commentInfo = commentFrame.commentInfo;
    //评论作者名字 就是电话
    self.author.text = commentInfo.author;

    //内容
    [self.textView setTitle:commentInfo.text forState:UIControlStateNormal];
    
    //设置消息背景图片
    [self.textView setBackgroundImage:[UIImage resizeImage:@"comment_background"] forState:UIControlStateNormal];
    
    self.author.frame = commentFrame.authorFrame;
    self.textView.frame = commentFrame.textFrame;

}

@end
