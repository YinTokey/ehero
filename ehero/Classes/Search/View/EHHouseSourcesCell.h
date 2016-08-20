//
//  EHHouseSourcesCell.h
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJTextView.h"
#import "EHHouseSourcesMessage.h"

@class EHHouseSourcesCell;
@protocol houseSourcesDelegate <NSObject>

- (void)extendBtnClick:(EHHouseSourcesCell *)cell;

@end



@interface EHHouseSourcesCell : UITableViewCell

@property(nonatomic,strong)EHHouseSourcesMessage *message;
@property (weak, nonatomic) IBOutlet UIButton *extendBtn;

@property (weak, nonatomic) IBOutlet UIImageView *line;
+ (instancetype)houseSourcesCellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet WJTextView *textView;

@property (nonatomic,weak)id<houseSourcesDelegate> delegate;

- (void)setClickEvent;



@property(nonatomic, copy) void (^showMoreTextBlock)(EHHouseSourcesCell  *currentCell);
///未展开时的高度
+ (CGFloat)cellDefaultHeight:(EHHouseSourcesCell *)entity;
///展开后的高度
+(CGFloat)cellMoreHeight:(EHHouseSourcesCell *)entity;

@end
