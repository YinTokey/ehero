//
//  EHAgentInfoCommentCell.m
//  ehero
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAgentInfoCommentCell.h"



@implementation EHAgentInfoCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}
- (IBAction)niceBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(niceClick:)]) {
        [self.delegate niceClick:self];
       
    }
}
- (IBAction)commonBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commonClick:)]) {
        [self.delegate commonClick:self];
    }
}
- (IBAction)badBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(badClick:)]) {
        [self.delegate badClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)AgentInfoCommentCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"AgentInfoCommentCell";
    EHAgentInfoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHAgentInfoCommentCell" owner:nil options:nil] lastObject];
        cell.backgroundColor = RGB(241, 243, 245);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.commentsArray = [NSMutableArray array];
        
    }
    
    return cell;
    
}

- (void)setCommentCounts{
    
    NSInteger high = 0;
    NSInteger mid = 0;
    NSInteger low = 0;
    
    for (EHCommentInfo *commentInfo in self.commentsArray) {
        if ([commentInfo.kind isEqualToString:@"nice"]) {
            high++;
        }
        if ([commentInfo.kind isEqualToString:@"common"]) {
            mid++;
        }
        if ([commentInfo.kind isEqualToString:@"bad"]) {
            low++;
        }
    }
    NSString *highStr = [NSString stringWithFormat:@"好评（%ld）",high];
    NSString *midStr = [NSString stringWithFormat:@"中评（%ld）",mid];
    NSString *lowStr = [NSString stringWithFormat:@"差评（%ld）",low];
    [self.highComment setTitle:highStr forState:UIControlStateNormal];
    [self.midComment setTitle:midStr forState:UIControlStateNormal];
    [self.lowComment setTitle:lowStr forState:UIControlStateNormal];
}

- (void)setClickEvent{
    //xcode7 自定义xib中要相应按钮事件，必须将cell加到contentView上，或者直接移除掉contentView
    [self.contentView removeFromSuperview];
    
}
@end
