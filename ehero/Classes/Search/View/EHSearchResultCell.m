//
//  EHSearchResultCell.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchResultCell.h"
#import "UILabel+GetWidth.h"
#import "YTNetCommand.h"
#import "EHCommunityLabel.h"
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
    
    EHCommunityLabel *communityLabel = [EHCommunityLabel communityLabel];
    
    
    //label改用动态创建，这样自适应才有效
    
    //没有小区
//    if (communitiesArr.count < 1) {
//        self.community1.hidden = YES;
//        self.community2.hidden = YES;
//        self.community3.hidden = YES;
//    }else if(communitiesArr.count == 1){
//        NSString *communityStr1 = [communitiesArr firstObject];
//        self.community1.text = communityStr1;
//        self.community1.frame = CGRectMake(0, 0, 100, 30);
//        self.community2.hidden = YES;
//        self.community3.hidden = YES;
//        CGFloat width = [UILabel getWidthWithTitle:self.community1.text font:self.community1.font];
//        UILabel *la = [[UILabel alloc]init];
//        la.text = communityStr1;
//        
//        
//     //   [self.community1 setFrame:CGRectMake(self.community1.frame.origin.x, self.community1.frame.origin.y, width, self.community1.frame.size.height)];
//        [self addSubview:self.community1];
//    }else if(communitiesArr.count == 2){
//        NSString *communityStr1 = [communitiesArr objectAtIndex:0];
//        NSString *communityStr2 = [communitiesArr objectAtIndex:1];
//        self.community1.text = communityStr1;
//        self.community2.text = communityStr2;
//        self.community3.hidden = YES;
//    }else{
//        NSString *communityStr1 = [communitiesArr objectAtIndex:0];
//        NSString *communityStr2 = [communitiesArr objectAtIndex:1];
//        NSString *communityStr3 = [communitiesArr objectAtIndex:2];
//        self.community1.text = communityStr1;
//        self.community2.text = communityStr2;
//        self.community3.text = communityStr3;
//        CGFloat width = [UILabel getWidthWithTitle:self.community2.text font:self.community2.font];
//        self.community2.frame = CGRectMake(self.community2.frame.origin.x, self.community2.frame.origin.y, width, self.community2.frame.size.height);
//        self.community3.frame = CGRectMake(20, 20, 150, 30);
//        
//        UILabel *la = [[UILabel alloc]init];
//        la.font = self.community2.font;
//        la.text = communityStr2;
//        UIColor *colorImg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"comment_btn_background"]];
//        [la setBackgroundColor:colorImg];
//        la.frame = CGRectMake(30, 40, width, 30);
//        [self addSubview:la];
//    }
    

}
- (IBAction)callClick:(id)sender {

    if ([self.delegate respondsToSelector:@selector(callBtnClick:)]) {
        [self.delegate callBtnClick:self];
    }
}
@end
