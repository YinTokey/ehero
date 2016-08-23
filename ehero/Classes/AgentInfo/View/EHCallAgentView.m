//
//  EHCallAgentView.m
//  ehero
//
//  Created by Mac on 16/7/28.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCallAgentView.h"
#import "YTNetCommand.h"
@interface EHCallAgentView()
@property (weak, nonatomic) IBOutlet UIView *callView;

@end

@implementation EHCallAgentView


+ (instancetype)initCallAgentView{

    EHCallAgentView *callAgentView = [[[NSBundle mainBundle] loadNibNamed:@"EHCallAgentView" owner:nil options:nil] lastObject];
    return callAgentView;
}

- (void)setCallAgentViewWithName:(NSString *)name mobile:(NSString *)mobile txUrl:(NSString *)txUrl{

    self.name.text = name;
    self.mobile.text = mobile;
    self.txView.image = [YTNetCommand downloadImageWithImgStr:txUrl
                                          placeholderImageStr:@"Profile"
                                                    imageView:_txView];
}

@end
