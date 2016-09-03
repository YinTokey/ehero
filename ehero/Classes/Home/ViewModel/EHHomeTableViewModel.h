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
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "EHTipsViewCell.h"

@interface EHHomeTableViewModel : NSObject<UITableViewDataSource,UITableViewDelegate,buttonCellDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,tipsViewCellDelegate>

@property (nonatomic,strong) id super;

@property (nonatomic,strong) UIViewController *superVC;

@property (nonatomic,strong) NSMutableArray *tipsRecommendArray;
@property (nonatomic,strong) NSMutableArray *imageUrlStrArray;


@property (nonatomic,strong) NewPagedFlowView *flowView;

@property (nonatomic,assign) BOOL netImageFlag;

- (void)getTipsInfo;

@end
