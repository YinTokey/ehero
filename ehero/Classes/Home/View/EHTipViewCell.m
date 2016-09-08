//
//  EHTipViewCell.m
//  易房好介
//
//  Created by Mac on 16/9/3.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipViewCell.h"
#import "YTNetCommand.h"
@interface EHTipViewCell()
- (IBAction)moreBtnClick:(id)sender;
- (IBAction)guessBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *guessButton;

@end

@implementation EHTipViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)tipViewCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseTipViewCell";
    EHTipViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHTipViewCell" owner:nil options:nil] lastObject];
        [cell setSize:CGSizeMake(ScreenWidth,ScreenHeight*0.47)];
        cell.pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight * 0.41)];
        cell.backgroundColor = RGB(238, 245, 250);
        cell.pageFlowView.backgroundColor = [UIColor clearColor];
        cell.pageFlowView.minimumPageAlpha = 0.1;
        cell.pageFlowView.minimumPageScale = 0.6;
        //提前告诉有多少页
        cell.pageFlowView.orginPageCount = 1;
    
        cell.pageFlowView.isOpenAutoScroll = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(cell.pageFlowView.frame.origin.x, 30, cell.pageFlowView.frame.size.width, cell.pageFlowView.size.height)];
      //  bottomScrollView.backgroundColor = [UIColor redColor];
        [bottomScrollView addSubview:cell.pageFlowView];
        
        [cell addSubview:bottomScrollView];
        
    }
    
    return cell;
    
}

- (void)setClickEvent{
    //xcode7 自定义xib中要相应按钮事件，必须将cell加到contentView上，或者直接移除掉contentView
     //   [self.contentView addSubview:_moreButton];
   //   [self.contentView addSubview:_guessButton];
  [self.contentView removeFromSuperview];

}

- (IBAction)moreBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(moreClick:)]) {
        [self.delegate moreClick:self];
    }
}

- (IBAction)guessBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(guessClick:)]) {
        [self.delegate guessClick:self];
    }
}

@end
