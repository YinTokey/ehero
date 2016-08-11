//
//  EHVerifyView.h
//  ehero
//
//  Created by Mac on 16/8/5.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EHVerifyView;
@protocol EHVerifyViewDelegate <NSObject>

@optional
- (void)closeVerifyView:(EHVerifyView *)verifyView code:(NSString *)code;


@end
@interface EHVerifyView : UIView

@property(nonatomic,weak) id<EHVerifyViewDelegate> delegate;

+ (instancetype)initVerifyView;
- (void)setupCountdownBtn;

@end
