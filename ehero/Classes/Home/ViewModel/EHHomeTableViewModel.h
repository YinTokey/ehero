//
//  EHHomeTableViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "buttonCell.h"
@interface EHHomeTableViewModel : NSObject<UITableViewDataSource,buttonCellDelegate>

@property (nonatomic,strong) id super;

@property (nonatomic,strong) UIViewController *superVC;
@end
