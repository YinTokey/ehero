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

@property (weak, nonatomic) IBOutlet UIButton *extendBtn;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;

@end

@implementation EHHouseSourcesCell
- (IBAction)extendBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(extendBtnClick:)]) {
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
