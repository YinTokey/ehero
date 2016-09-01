//
//  EHTipsViewCell.m
//  ehero
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewCell.h"


@implementation EHTipsViewCell

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
        cell.pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 8, ScreenWidth, (ScreenWidth - 84) * 9 / 16 + 24)];
        cell.pageFlowView.backgroundColor = [UIColor whiteColor];
//        pageFlowView.delegate = self;
//        pageFlowView.dataSource = self;
        cell.pageFlowView.minimumPageAlpha = 0.4;
        cell.pageFlowView.minimumPageScale = 0.85;
        
        //提前告诉有多少页
        cell.pageFlowView.orginPageCount = 3;
        
        cell.pageFlowView.isOpenAutoScroll = YES;
        
        //初始化pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, cell.pageFlowView.frame.size.height - 24 - 8, ScreenWidth, 8)];
        cell.pageFlowView.pageControl = pageControl;
        [cell.pageFlowView addSubview:pageControl];
        
        UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:cell.bounds];
        [bottomScrollView addSubview:cell.pageFlowView];
        
        [cell addSubview:bottomScrollView];
        
    }
    
    return cell;
    
}


@end
