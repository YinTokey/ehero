//
//  EHHomeSearchBar.h
//  ehero
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EHHomeSearchBarDelegate <NSObject>

- (void)searchBtnClick;

@end

@interface EHHomeSearchBar : UITextField

@property (nonatomic,weak)id<EHHomeSearchBarDelegate> EHSearchBtndelegate;

@end
