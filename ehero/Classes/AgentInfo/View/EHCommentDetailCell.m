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
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)setCommentInfo:(EHCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    self.textView.text = commentInfo.text;
    self.authoer.text = commentInfo.author;
    //文字高度计算
    CGRect rect = [self.textView.text boundingRectWithSize:CGSizeMake(300,9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];

    commentInfo.cellHeight = rect.size.height + 60;
}

@end
