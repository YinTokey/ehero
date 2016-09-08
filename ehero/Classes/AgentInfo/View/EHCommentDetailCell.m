//
//  EHCommentDetailCell.m
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentDetailCell.h"
#import "EHCommentFrame.h"
#import "UIImage+Extensiton.h"
@interface EHCommentDetailCell ()

@end


@implementation EHCommentDetailCell

+ (instancetype)commentDetailCellCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"commentDetailCell";
    EHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHCommentDetailCell" owner:nil options:nil] lastObject];
        cell.textView.backgroundColor = [UIColor blueColor];
        [cell.textView textRectForBounds:cell.textView.frame limitedToNumberOfLines:0];
        
    }
    return cell;
}


/*
//2 创建子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //背景图
        UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height)];
        [background setImage:[UIImage resizeImage:@"comment_background"]] ;
       // [UIImageView :[UIImage resizeImage:@"comment_background"] forState:UIControlStateNormal];
        [self.contentView addSubview:background];
        self.background = background;
        

        // 评论内容
        UITextView *textView = [[UITextView alloc] init];
        [self.background addSubview:textView];
        //设置字体大小
        textView.font = [UIFont systemFontOfSize:13];
        //设置换行
      //  textView.numberOfLines = 0;
        //设置字体的颜色
       // [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置按钮中内容的边距
     //   textView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       // CGFloat offsetTop = textView.bounds.origin.y + 2;
       //CGFloat offsetTop = textView.frame.origin.y - textView.titleLabel.frame.origin.y ;
      //  textView.contentEdgeInsets = UIEdgeInsetsMake( 0, 0, 0, 15);
       // textView.backgroundColor = [UIColor redColor];
        textView.backgroundColor = [UIColor clearColor];
        self.textView = textView;
        
        // 电话
        UILabel *author = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 40, 20)];
        [self.background addSubview:author];
        author.textAlignment = NSTextAlignmentLeft;
        author.font = [UIFont systemFontOfSize:13];
        self.author = author;
        
        // 点赞按钮
        UIButton *starBtn = [[UIButton alloc]init];
        [starBtn setImage:[UIImage imageNamed:@"starIcon"] forState:UIControlStateNormal];
        [self.background addSubview:starBtn];
        self.starBtn = starBtn;
        
        // 小区
        EHCommunityButton *communityBtn = [[EHCommunityButton alloc]init];
        [self.background addSubview:communityBtn];
        self.communityBtn = communityBtn;
        // 提交评论时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [self.background addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
    }
    return self;
}
*/
/*
- (void)setCommentFrame:(EHCommentFrame *)commentFrame{
    commentFrame.superCell = self;
    _commentFrame = commentFrame;
    
    EHCommentInfo *commentInfo = commentFrame.commentInfo;
    //评论作者名字 就是电话
    self.author.text = commentInfo.author;

    //内容
  //  [self.textView setTitle:commentInfo.text forState:UIControlStateNormal];
    self.textView.text = commentInfo.text;
    //设置消息背景图片
  //  [self.textView setBackgroundImage:[UIImage resizeImage:@"comment_background"] forState:UIControlStateNormal];
    
    self.author.frame = commentFrame.authorFrame;
    self.starBtn.frame = commentFrame.starFrame;
    self.textView.frame = commentFrame.textFrame;
    self.background.frame = commentFrame.backgroundFrame;
    
}
*/

- (void)setCommentInfo:(EHCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    self.textView.text = commentInfo.text;
    self.authoer.text = commentInfo.author;
    CGFloat commentH = [self.textView.text boundingRectWithSize:CGSizeMake(204, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
    
    commentInfo.cellHeight = commentH + 60;
}

@end
