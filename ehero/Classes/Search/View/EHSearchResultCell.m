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
#import "UILabel+GetWidth.h"
#import "EHLabel.h"
@interface EHSearchResultCell()
{
   CGFloat x;
}
@property (weak, nonatomic) IBOutlet UIImageView *txView;
@property (weak, nonatomic) IBOutlet UILabel *name;
//@property (weak, nonatomic) IBOutlet EHLabel *position;

@property (weak, nonatomic) IBOutlet UILabel *rates;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *mainRegion;



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
     //   cell.position.backgroundColor = RGB(234, 243, 248);
     //   cell.region.backgroundColor = RGB(68, 180, 244);
        
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
    if (agentInfo.position.length > 1) {
        EHLabel *position = [EHLabel LabelWithText:agentInfo.position];
        position.backgroundColor = RGB(234, 243, 248);
        position.frame = CGRectMake(137, 13, position.textWidth + 10, 17);
        position.textColor = RGB(68, 180, 244);
        [self addSubview:position];
        position.sd_layout.leftSpaceToView(self.name,5);
    }
    
    if (agentInfo.percentile.length < 1) {
        self.rates.text = @"";
    }else{
        self.rates.text = [NSString stringWithFormat:@"%@％",agentInfo.percentile];
    }
    self.company.text = agentInfo.company;
    NSArray *rArray = [agentInfo.region componentsSeparatedByString:@" "];
    NSMutableArray *regionsArray = [NSMutableArray array];
    for (NSString *str in rArray) {
        if (str.length > 1) {
            [regionsArray addObject:str];
        }
    }
    if (regionsArray.count == 1) {
        NSString *regionStr = regionsArray[0];
        EHLabel *label = [EHLabel LabelWithText:regionStr];
        label.frame = CGRectMake(self.mainRegion.frame.origin.x + 66,69, label.textWidth+10, 17);
        [self addSubview:label];
    }
 
    if (regionsArray.count == 2) {
        NSString *regionStr0 = regionsArray[0];
        NSString *regionStr1 = regionsArray[1];
        EHLabel *label0 = [EHLabel LabelWithText:regionStr0];
        label0.frame = CGRectMake(self.mainRegion.frame.origin.x + 66,69, label0.textWidth+10, 17);
        [self addSubview:label0];
        EHLabel *label1 = [EHLabel LabelWithText:regionStr1];
        label1.frame = CGRectMake(label0.frame.origin.x + label0.frame.size.width + 5 ,69, label1.textWidth+10, 17);
        [self addSubview:label1];
        if ((label1.frame.origin.x + label1.frame.size.width + 5) > self.callButton.frame.origin.x) {
            label1.hidden = YES;
        }
    }
    if (regionsArray.count >=3) {
        NSString *regionStr0 = regionsArray[0];
        NSString *regionStr1 = regionsArray[1];
        NSString *regionStr2 = regionsArray[2];
        EHLabel *label0 = [EHLabel LabelWithText:regionStr0];
        label0.frame = CGRectMake(self.mainRegion.frame.origin.x + 66,69, label0.textWidth+10, 17);
        [self addSubview:label0];
        EHLabel *label1 = [EHLabel LabelWithText:regionStr1];
        label1.frame = CGRectMake(label0.frame.origin.x + label0.frame.size.width + 5 ,69, label1.textWidth+10, 17);
        [self addSubview:label1];
        EHLabel *label2 = [EHLabel LabelWithText:regionStr2];
        label2.frame = CGRectMake(label1.frame.origin.x + label1.frame.size.width + 5 ,69, label2.textWidth+10, 17);
        [self addSubview:label2];
        if ((label2.frame.origin.x + label2.frame.size.width + 5) > self.callButton.frame.origin.x) {
            label2.hidden = YES;
        }
        
    }
    
    //将小区分割成3个 存数组里
    NSArray *array = [agentInfo.community componentsSeparatedByString:@" "];
    NSMutableArray *communitiesArr = [NSMutableArray array];
    for (NSString *comStr in array) {
        if (comStr.length >= 1) {
            [communitiesArr addObject:comStr];
        }
    }
    CGFloat y = 101;
    //用动态创建，这样自适应才有效
    if (communitiesArr.count == 1)
    {
        NSString *comStr = [communitiesArr objectAtIndex:0];
        EHCommunityButton *comBtn = [EHCommunityButton communityButton:comStr];
        comBtn.frame = CGRectMake( 75 , y, comBtn.realWidth+10, 20);
        [self addSubview:comBtn];
    }
    if(communitiesArr.count == 2)
    {
        NSString *comStr0 = [communitiesArr objectAtIndex:0];
        EHCommunityButton *comBtn0 = [EHCommunityButton communityButton:comStr0];
        NSString *comStr1 = [communitiesArr objectAtIndex:1];
        EHCommunityButton *comBtn1 = [EHCommunityButton communityButton:comStr1];
        CGFloat x0 = 75;
        CGFloat x1 = x0 + comBtn0.realWidth+10 + 4;
        comBtn0.frame = CGRectMake(x0, y, comBtn0.realWidth+12, 20);
        comBtn1.frame = CGRectMake(x1, y, comBtn1.realWidth+12, 20);
        [self addSubview:comBtn0];
        [self addSubview:comBtn1];
    }
    if(communitiesArr.count == 3)
    {
        NSString *comStr0 = [communitiesArr objectAtIndex:0];
        EHCommunityButton *comBtn0 = [EHCommunityButton communityButton:comStr0];
        NSString *comStr1 = [communitiesArr objectAtIndex:1];
        EHCommunityButton *comBtn1 = [EHCommunityButton communityButton:comStr1];
        NSString *comStr2 = [communitiesArr objectAtIndex:2];
        EHCommunityButton *comBtn2 = [EHCommunityButton communityButton:comStr2];
        CGFloat x0 = 75;
        CGFloat x1 = x0 + comBtn0.realWidth+10 + 4;
        CGFloat x2 = x1 + comBtn1.realWidth+10 + 4;
        comBtn0.frame = CGRectMake(x0 , y, comBtn0.realWidth+10, 20);
        comBtn1.frame = CGRectMake(x1 , y, comBtn1.realWidth+10, 20);
        comBtn2.frame = CGRectMake(x2 , y, comBtn2.realWidth+10, 20);
        [self addSubview:comBtn0];
        [self addSubview:comBtn1];
        [self addSubview:comBtn2];
        if ((comBtn2.frame.origin.x + comBtn2.frame.size.width) > ScreenWidth) {
            comBtn2.hidden = YES;
        }
    }
    
    /*
  //  x = 75;
    for (NSInteger i = 0;i < communitiesArr.count; i++) {
        
        NSString *comStr = [communitiesArr objectAtIndex:i];
        EHCommunityButton *comBtn = [EHCommunityButton communityButton:comStr];
        if (i == 0) {
            x = 75;
        }else if(i >= 1){
            x = x + comBtn.realWidth + 5;
        }
    //    x = x + (comBtn.realWidth + 5) ;

        comBtn.frame = CGRectMake( x , 95, comBtn.realWidth, 16);
        [self addSubview:comBtn];
    }
     */
    

}


- (IBAction)callClick:(id)sender {

    if ([self.delegate respondsToSelector:@selector(callBtnClick:)]) {
        [self.delegate callBtnClick:self];
    }
}
@end
