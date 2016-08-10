//
//  EHSearchResultCell.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchResultCell.h"
#import "YTNetCommand.h"
#import "UIButton+GetWidth.h"
#import "EHCommunityButton.h"
@interface EHSearchResultCell()
@property (weak, nonatomic) IBOutlet UIImageView *txView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *rates;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *region;


- (IBAction)callClick:(id)sender;


@end

@implementation EHSearchResultCell


- (void)drawRect:(CGRect)rect
{
    
    if (self.isdrawRect == YES) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        //上分割线，
        CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
        CGRect topRect = CGRectMake(0, 0, rect.size.width , 8);
        CGContextStrokeRect(context,topRect);
        CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
        CGContextFillRect(context,topRect);
        
        //下分割线
//        CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
//        CGRect bottomRect = CGRectMake(0, rect.size.height, rect.size.width, 8);
//        CGContextStrokeRect(context, bottomRect);
//        CGContextSetFillColorWithColor(context, RGB(241, 243, 245).CGColor);
//        CGContextFillRect(context,bottomRect);
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

+ (instancetype)searchResultCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"reuseSearchResultCell";
    EHSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EHSearchResultCell" owner:nil options:nil] lastObject];
        cell.position.backgroundColor = RGB(234, 243, 248);
        cell.region.backgroundColor = RGB(68, 180, 244);
        
//        UIColor *colorImg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"comment_btn_background"]];
//        [cell.community1 setBackgroundColor:colorImg];
//        [cell.community2 setBackgroundColor:colorImg];
//        [cell.community3 setBackgroundColor:colorImg];
    }
    
    return cell;
    
}

- (void)setResultCell:(EHAgentInfo *)agentInfo{
    self.txView.image = [YTNetCommand downloadImageWithImgStr:agentInfo.tx
                                          placeholderImageStr:@"Profile"
                                                    imageView:_txView];
    self.name.text = agentInfo.name;
    if (agentInfo.position.length < 1) {
        self.position.hidden = YES;
    }else{
        self.position.text = agentInfo.position;
    }
    
    if (agentInfo.rates.length < 1) {
        self.rates.text = @"";
    }else{
        self.rates.text = [NSString stringWithFormat:@"%@％",agentInfo.rates];
    }
    self.company.text = agentInfo.company;
    self.region.text = agentInfo.region;

    
    //将小区分割成3个 存数组里
    NSArray *array = [agentInfo.community componentsSeparatedByString:@" "];
    NSMutableArray *communitiesArr = [NSMutableArray array];
    for (NSString *comStr in array) {
        if (comStr.length >= 1) {
            [communitiesArr addObject:comStr];
        }
    }
    
    //用动态创建，这样自适应才有效
    for (NSInteger i = 0;i < communitiesArr.count; i++) {
        NSString *comStr = [communitiesArr objectAtIndex:i];
        EHCommunityButton *comBtn = [EHCommunityButton communityButton:@"永泰西里一区"];
    }
    EHCommunityButton *comBtn1 = [EHCommunityButton communityButton:@"永泰西里一区"];
    comBtn1.frame = CGRectMake(70, 95, comBtn1.realWidth, 16);
    
    
    [self addSubview:comBtn1];
    
    
    
    
    
    
    



}
- (IBAction)callClick:(id)sender {

    if ([self.delegate respondsToSelector:@selector(callBtnClick:)]) {
        [self.delegate callBtnClick:self];
    }
}
@end
