//
//  buttonCell.m
//  ehero
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "buttonCell.h"
@interface buttonCell()
@property (weak, nonatomic) IBOutlet UIButton *tips;
@property (weak, nonatomic) IBOutlet UIButton *phoneCall;
@property (weak, nonatomic) IBOutlet UIButton *wechatGroup;
@property (weak, nonatomic) IBOutlet UIButton *everyHouse;




@end

@implementation buttonCell
//3.向代理对象发送消息
- (IBAction)firstBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(firstBtnClick:)]) {
        [self.delegate firstBtnClick:self];
    }
}
- (IBAction)secondBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(secondBtnClick:)]) {
        [self.delegate secondBtnClick:self];
    }
    
}
- (IBAction)thirdBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(thirdBtnClick:)]) {
        [self.delegate thirdBtnClick:self];
    }
}

- (IBAction)fourthBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fourthBtnClick:)]) {
        [self.delegate fourthBtnClick:self];
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)buttonCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseButtonCell";
    buttonCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"buttonCell" owner:nil options:nil] lastObject];
    //    [cell setupAutoHeightWithBottomView:_view4 bottomMargin:10];
        
//        cell.tips.sd_layout
//        .widthRatioToView(cell,0.246875)
//        .heightRatioToView (cell,1)
//        .leftSpaceToView (cell,0)
//        .rightSpaceToView (cell.phoneCall,2);
//        
//        cell.phoneCall.sd_layout
//        .widthRatioToView(cell,0.246875)
//        .heightRatioToView (cell,1)
//        .leftSpaceToView (cell.tips,2)
//        .rightSpaceToView (cell.wechatGroup,2);
//        
//        cell.wechatGroup.sd_layout
//        .widthRatioToView(cell,0.246875)
//        .heightRatioToView (cell,1)
//        .leftSpaceToView (cell.phoneCall,2)
//        .rightSpaceToView (cell.everyHouse,2);
//        
//        cell.phoneCall.sd_layout
//        .widthRatioToView(cell,0.246875)
//        .heightRatioToView (cell,1)
//        .leftSpaceToView (cell.wechatGroup,2)
//        .rightSpaceToView (cell,-2);
    }

    return cell;
    
}

- (void)setClickEvent{
    //xcode7 自定义xib中要相应按钮事件，必须将cell加到contentView上，或者直接移除掉contentView
    [self.contentView removeFromSuperview];

}

@end
