//
//  EHCallAgentView.h
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EHCallAgentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *txView;
@property (weak, nonatomic) IBOutlet UILabel *mobile;
@property (weak, nonatomic) IBOutlet UILabel *name;

+ (instancetype)initCallAgentView;

- (void)setCallAgentViewWithName:(NSString *)name mobile:(NSString *)mobile txUrl:(NSString *)txUrl;
@end
