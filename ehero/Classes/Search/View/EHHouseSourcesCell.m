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

- (void)drawRect:(CGRect)rect
{

        CGContextRef context = UIGraphicsGetCurrentContext();
        //上分割线，
        CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
        CGRect topRect = CGRectMake(0, 0, rect.size.width , 2);
        CGContextStrokeRect(context,topRect);
        CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
        CGContextFillRect(context,topRect);
 
}


+ (instancetype)houseSourcesCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"HouseSourcesCell";
    //设置轮播图片
   // NSMutableArray *sourceArr = [NSMutableArray arrayWithObjects:@"house1",@"house2",@"house3", nil];
    EHHouseSourcesCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHHouseSourcesCell" owner:nil options:nil] lastObject];
        

    }
    
    return cell;
    
}

- (void)setClickEvent{
    //xcode7 自定义xib中要相应按钮事件，必须将cell加到contentView上，或者直接移除掉contentView
    [self.contentView removeFromSuperview];
    
}

- (void)setHouseInfo:(EHHousesInfo *)houseInfo{
    
    _houseInfo = houseInfo;
    
    NSString *name = [NSString stringWithFormat:@"经纪人 %@",_houseInfo.name];
    self.name.text = name;
    NSString *updated_at = [_houseInfo.updated_at substringWithRange:NSMakeRange(0, 10)];
    self.updated_at.text = updated_at;
    self.price.text = _houseInfo.price;
    self.titleLabel.text =  _houseInfo.title;
    self.desciptionLabel.text = _houseInfo.descriptions;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    //文字高度计算
    CGRect rect = [self.desciptionLabel.text boundingRectWithSize:CGSizeMake(300,9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];

    houseInfo.cellHeight = rect.size.height + 320;

    //处理图片下载
    NSArray *imgUrlStrArray = [houseInfo.thumbs componentsSeparatedByString:@" "];  
    
    //设置轮播图片
    self.cycleView.imageURLStringsGroup = imgUrlStrArray;
    self.cycleView.autoScrollTimeInterval = 300;
    
}
@end
