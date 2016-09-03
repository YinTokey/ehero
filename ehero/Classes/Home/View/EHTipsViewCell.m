//
//  EHTipsViewCell.m
//  ehero
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewCell.h"
#import "SDAutoLayout.h"
#import "YTNetCommand.h"
@interface EHTipsViewCell()
- (IBAction)moreBtnClick:(id)sender;
- (IBAction)guessBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *guessButton;

@end

@implementation EHTipsViewCell
//- (IBAction)moreBtnClick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(moreClick:)]) {
//        [self.delegate moreClick:self];
//    }
//}
//- (IBAction)guessBtnClick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(guessClick:)]) {
//        [self.delegate guessClick:self];
//    }
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)tipsViewCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseHomeAgentCell";
    EHTipsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHTipsViewCell" owner:nil options:nil] lastObject];
        [cell setSize:CGSizeMake(ScreenWidth,ScreenHeight*0.47)];
        cell.pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 30,ScreenWidth , ScreenHeight * 0.41)];
        
        cell.pageFlowView.backgroundColor = [UIColor clearColor];
        //        pageFlowView.delegate = self;
        //        pageFlowView.dataSource = self;
        cell.pageFlowView.minimumPageAlpha = 0.1;
        cell.pageFlowView.minimumPageScale = 0.6;
        //提前告诉有多少页
        cell.pageFlowView.orginPageCount = 3;
        
        cell.pageFlowView.isOpenAutoScroll = YES;
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:cell.bounds];
        
        [bottomScrollView addSubview:cell.pageFlowView];
        
        [cell addSubview:bottomScrollView];
        
    }
    
    return cell;
    
}

- (void)setClickEvent{
    //xcode7 自定义xib中要相应按钮事件，必须将cell加到contentView上，或者直接移除掉contentView
    [self.contentView addSubview:_moreButton];
    [self.contentView addSubview:_guessButton];
    
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
