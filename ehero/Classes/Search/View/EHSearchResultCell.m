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
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *region;
@property (weak, nonatomic) IBOutlet UILabel *community;
@property (weak, nonatomic) IBOutlet UILabel *rate;


@end

@implementation EHSearchResultCell
- (IBAction)call:(id)sender {
    NSLog(@"给经纪人打电话");
    
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
        
    }
    
    return cell;
    
}

- (void)setResultCell:(EHAgentInfo *)agentInfo{
    self.txView.image = [YTNetCommand downloadImageWithImgStr:agentInfo.tx
                                          placeholderImageStr:@"Profile"
                                                    imageView:_txView];
    self.name.text = agentInfo.name;
    self.company.text = agentInfo.company;
    self.city.text = agentInfo.city;
    self.region.text = agentInfo.region;
    self.community.text = agentInfo.community;
    self.rate.text = agentInfo.rates;
    
    
}
@end
