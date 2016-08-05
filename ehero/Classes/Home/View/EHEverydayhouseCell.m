//
//  EHEverydayhouseCell.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHEverydayhouseCell.h"

@implementation EHEverydayhouseCell

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
    CGRect topRect = CGRectMake(0, 0, rect.size.width , 8);
    CGContextStrokeRect(context,topRect);
    CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
    CGContextFillRect(context,topRect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
    CGRect bottomRect = CGRectMake(0, rect.size.height, rect.size.width, 8);
    CGContextStrokeRect(context, bottomRect);
    CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
    CGContextFillRect(context,topRect);

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
    }
    
    return cell;
    
}


@end
