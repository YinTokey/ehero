//
//  EHSearchResultCell.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchResultCell.h"

#import "YTNetCommand.h"
@interface EHSearchResultCell()
@property (weak, nonatomic) IBOutlet UIImageView *txView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *rates;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *community1;
@property (weak, nonatomic) IBOutlet UILabel *community2;
@property (weak, nonatomic) IBOutlet UILabel *community3;

- (IBAction)callClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *communities;

@end

@implementation EHSearchResultCell


- (void)drawRect:(CGRect)rect
{
    
    if (self.isdrawRect == YES) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        //上分割线，
        CGContextSetStrokeColorWithColor(context,RGB(241, 243, 245).CGColor);
        CGRect topRect = CGRectMake(-3, 0, rect.size.width , 8);
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
    self.communities.text = agentInfo.community;
//    //判断主营小区个数 ,分割空格符，存在bug，这段先放着
//    NSArray *communitiesArr = [agentInfo.community componentsSeparatedByString:@" "];
//    if (communitiesArr.count < 1) {
//        self.community1.hidden = YES;
//        self.community2.hidden = YES;
//        self.community3.hidden = YES;
//    }else if(communitiesArr.count == 1){
//        NSString *communityStr1 = [communitiesArr firstObject];
//        self.community1.text = communityStr1;
//        self.community2.hidden = YES;
//        self.community3.hidden = YES;
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
//    }

}
- (IBAction)callClick:(id)sender {

    if ([self.delegate respondsToSelector:@selector(callBtnClick:)]) {
        [self.delegate callBtnClick:self];
    }
}
@end
