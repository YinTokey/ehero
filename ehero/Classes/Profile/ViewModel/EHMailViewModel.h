//
//  EHMailViewModel.h
//  ehero
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
@interface EHMailViewModel : NSObject<MFMailComposeViewControllerDelegate>

@property (nonatomic,strong) UIViewController *superVC;

- (void)sendEmailAction;

@end
