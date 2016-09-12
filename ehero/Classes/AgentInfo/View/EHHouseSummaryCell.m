//
//  EHHouseSummaryCell.m
//  易房好介
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHouseSummaryCell.h"

@implementation EHHouseSummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)houseSummaryCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"HouseSummaryCell";
    //设置轮播图片
    // NSMutableArray *sourceArr = [NSMutableArray arrayWithObjects:@"house1",@"house2",@"house3", nil];
    EHHouseSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseSummaryCell" owner:nil options:nil] lastObject];

        
    }
    
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHouseInfo:(EHHousesInfo *)houseInfo{
    _houseInfo = houseInfo;
    self.title.text = _houseInfo.title;
    self.price.text = _houseInfo.price;
    self.model.text = _houseInfo.model;
    //处理图片下载
    NSArray *imgUrlStrArray = [houseInfo.thumbs componentsSeparatedByString:@" "];
    NSString *firstImgStr = [imgUrlStrArray firstObject];
    self.imgView.image = [YTNetCommand downloadImageWithImgStr:firstImgStr placeholderImageStr:@"home_placeholder" imageView:self.imgView];
}

@end
