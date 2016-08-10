//
//  EHCommunityButton.h
//  ehero
//
//  Created by Mac on 16/8/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHCommunityButton : UIButton

+ (instancetype)communityButton:(NSString *)title;
@property (nonatomic,assign)CGFloat realWidth;

@end
