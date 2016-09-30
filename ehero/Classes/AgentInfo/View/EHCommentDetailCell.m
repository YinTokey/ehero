//
//  EHCommentDetailCell.m
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentDetailCell.h"
#import "UIImage+Extension.h"
@interface EHCommentDetailCell ()

@end


@implementation EHCommentDetailCell

+ (instancetype)commentDetailCellCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"commentDetailCell";
    EHCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHCommentDetailCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

//使cell一定成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}

//支持的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)setCommentInfo:(EHCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    self.textView.text = commentInfo.text;
    NSString *authorStr = [commentInfo.author stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.author.text = authorStr;
    
    NSString *created_at = [commentInfo.created_at substringWithRange:NSMakeRange(0, 10)];
    self.timeLabel.text = created_at;

    EHCommunityButton *comBtn = [EHCommunityButton communityButton:commentInfo.community];

    [self addSubview:comBtn];
    comBtn.sd_layout
    .rightSpaceToView(self.timeLabel,2)
    .widthIs(comBtn.realWidth+16)
    .heightIs(20)
    .bottomSpaceToView(self,12);
  
    if ([commentInfo.kind isEqualToString:@"bad"]) {
        [self.starView setImage:[UIImage imageNamed:@"starIcon2"]];
       // NSLog(@"in cell bad");
    }
    if ([commentInfo.kind isEqualToString:@"common"]) {
        self.starView.hidden = YES;
    }
    
    UIView *bottomView = self.textView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
    //文字高度计算

    self.textView.sd_layout.widthIs(ScreenWidth -33);
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];

    self.textView.sd_layout
    .heightIs(textSize.height);

    commentInfo.cellHeight = self.textView.bounds.size.height + 60;

}


@end
