//
//  EHLabel.h
//  易房好介
//
//  Created by Mac on 16/9/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHLabel : UILabel

@property (nonatomic,assign)CGFloat textWidth;
+ (instancetype)LabelWithText:(NSString *)text;
@end
