//
//  EHHouseSourcesCell.m
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseSourcesCell.h"
#import <SDCycleScrollView.h>

@interface EHHouseSourcesCell()


@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;

@end

@implementation EHHouseSourcesCell

+ (CGFloat)cellDefaultHeight:(EHHouseSourcesMessage *)message
{
    //默认cell高度
    return 300.0;
}

+ (CGFloat)cellMoreHeight:(EHHouseSourcesMessage *)message
{
    //展开后得高度(计算出文本内容的高度+固定控件的高度)
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [message.textContent boundingRectWithSize:CGSizeMake(ScreenWidth - 30, 100000) options:option attributes:attribute context:nil].size;;
    return size.height + 50;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    _textView.text = self.message.textContent;
//    if (self.message.isShowMoreText)
//    {
//        ///计算文本高度
//        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
//        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
//        CGSize size = [self.message.textContent boundingRectWithSize:CGSizeMake(ScreenWidth - 30, 100000) options:option attributes:attribute context:nil].size;
//        [self.textView setFrame:CGRectMake(15, 30, ScreenWidth - 30, size.height)];
//    }
//    else
//    {
//        [self.textView setFrame:CGRectMake(15, 30, ScreenWidth - 30, 35)];
//    }
//    
//}

- (IBAction)extendBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(extendBtnClick:)]) {
//        self.message.isShowMoreText =  !self.message.isShowMoreText;
//        if (self.showMoreTextBlock)
//        {
//            self.showMoreTextBlock(self);
//        }
        [self.delegate extendBtnClick:self];
    }
}




+ (instancetype)houseSourcesCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"HouseSourcesCell";
    //设置轮播图片
    NSMutableArray *sourceArr = [NSMutableArray arrayWithObjects:@"house1",@"house2",@"house3", nil];
    EHHouseSourcesCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseSourcesCell" owner:nil options:nil] lastObject];

        cell.cycleView.localizationImageNamesGroup = sourceArr;
        cell.cycleView.autoScrollTimeInterval = 300;

    }
    
    return cell;
    
}

- (void)setClickEvent{
    //xcode7 自定义xib中要相应按钮事件，必须将cell加到contentView上，或者直接移除掉contentView
    [self.contentView removeFromSuperview];
    
}

@end
