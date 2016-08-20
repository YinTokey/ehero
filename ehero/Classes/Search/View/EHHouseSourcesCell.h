//
//  EHHouseSourcesCell.h
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJTextView.h"
@class EHHouseSourcesCell;
@protocol houseSourcesDelegate <NSObject>

- (void)extendBtnClick:(EHHouseSourcesCell *)cell;

@end



@interface EHHouseSourcesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *line;
+ (instancetype)houseSourcesCellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet WJTextView *textView;

@property (nonatomic,weak)id<houseSourcesDelegate> delegate;

- (void)setClickEvent;

@end
