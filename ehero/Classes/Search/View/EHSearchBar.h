//
//  EHSearchBar.h
//  ehero
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EHSearchBarDelegate <NSObject>

- (void)searchBtnClick;

@end

@interface EHSearchBar : UITextField

@property (nonatomic,weak)id<EHSearchBarDelegate> EHSearchBtndelegate;

@end
