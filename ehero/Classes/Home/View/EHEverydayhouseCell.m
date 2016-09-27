//
//  EHEverydayhouseCell.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHEverydayhouseCell.h"
#import "EHCommunityButton.h"

@implementation EHEverydayhouseCell

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
    
    //上分割线，
//    CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
//    CGRect topRect = CGRectMake(0, 0, rect.size.width , 4);
//    CGContextStrokeRect(context,topRect);
//    CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
//    CGContextFillRect(context,topRect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
    CGRect bottomRect = CGRectMake(0, rect.size.height - 4, rect.size.width, 4);
    CGContextStrokeRect(context, bottomRect);
    CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
    CGContextFillRect(context,bottomRect);

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)everydayhouseCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseEverydayhouseCell";
    EHEverydayhouseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHEverydayhouseCell" owner:nil options:nil] lastObject];
        CGRect rect = [cell.price.text boundingRectWithSize:CGSizeMake(300,9999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]} context:nil];
        cell.price.sd_layout
        .widthIs(rect.size.width);
    }
    
    return cell;
    
}

- (void)setHouseInfo:(EHHousesInfo *)houseInfo{
    _houseInfo = houseInfo;
    self.titleLabel.text = _houseInfo.title;
    self.price.text = _houseInfo.price;
    NSString *modelText = [NSString stringWithFormat:@"%@  %@  %@",_houseInfo.model,_houseInfo.area,_houseInfo.toward];
    self.model.text = modelText;
    NSString *clickStr ;
    if (_houseInfo.clicks == nil) {
       clickStr = [NSString stringWithFormat:@"点击量：0"];
    }else{
       clickStr = [NSString stringWithFormat:@"点击量：%@",_houseInfo.clicks];
    }
    EHCommunityButton *comBtn = [EHCommunityButton communityButton:clickStr];
    comBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    comBtn.frame = CGRectMake( 8 ,77,comBtn.realWidth, 13);
    
    [self addSubview:comBtn];
    //处理图片下载
    NSArray *imgUrlStrArray = [houseInfo.thumbs componentsSeparatedByString:@" "];
    NSString *firstImgStr = [imgUrlStrArray firstObject];
    self.imgView.image = [YTNetCommand downloadImageWithImgStr:firstImgStr placeholderImageStr:@"home_placeholder" imageView:self.imgView];
    self.name.text = houseInfo.name;
    NSString *updated_at = [_houseInfo.updated_at substringWithRange:NSMakeRange(0, 10)];
    self.updated_at.text = updated_at;
    
}

@end
