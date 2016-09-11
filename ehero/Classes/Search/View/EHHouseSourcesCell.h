//
//  EHHouseSourcesCell.h
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHousesInfo.h"

@class EHHouseSourcesCell;
@protocol houseSourcesDelegate <NSObject>

- (void)extendBtnClick:(EHHouseSourcesCell *)cell;

@end



@interface EHHouseSourcesCell : UITableViewCell

@property(nonatomic,strong)EHHousesInfo *houseInfo;

@property (weak, nonatomic) IBOutlet UILabel *desciptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *updated_at;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)houseSourcesCellWithTableView:(UITableView *)tableView;


@property (nonatomic,weak)id<houseSourcesDelegate> delegate;

- (void)setClickEvent;


//
//@property(nonatomic, copy) void (^showMoreTextBlock)(EHHouseSourcesCell  *currentCell);
/////未展开时的高度
//+ (CGFloat)cellDefaultHeight:(EHHouseSourcesCell *)entity;
/////展开后的高度
//+(CGFloat)cellMoreHeight:(EHHouseSourcesCell *)entity;

@end
