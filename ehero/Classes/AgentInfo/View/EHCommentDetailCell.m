//
//  EHCommentDetailCell.m
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentDetailCell.h"
#import "UIImage+Extensiton.h"
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

- (void)setCommentInfo:(EHCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    self.textView.text = commentInfo.text;
    self.authoer.text = commentInfo.author;
    NSString *created_at = [commentInfo.created_at substringWithRange:NSMakeRange(0, 10)];
    self.timeLabel.text = created_at;

    EHCommunityButton *comBtn = [EHCommunityButton communityButton:commentInfo.community];

    [self addSubview:comBtn];
    comBtn.sd_layout
    .rightSpaceToView(self.timeLabel,2)
    .widthIs(comBtn.realWidth)
    .heightIs(16)
    .bottomSpaceToView(self,12);
  
    if ([commentInfo.kind isEqualToString:@"差评"]) {
        [self.starView setImage:[UIImage imageNamed:@"starIcon2"]];
    }
    if ([commentInfo.kind isEqualToString:@"中评"]) {
        self.starView.hidden = YES;
    }
    
    //文字高度计算
    CGRect rect = [self.textView.text boundingRectWithSize:CGSizeMake(300,9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];

    commentInfo.cellHeight = rect.size.height + 80;
}

@end
