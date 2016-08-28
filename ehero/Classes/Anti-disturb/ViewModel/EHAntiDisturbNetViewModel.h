//
//  EHAntiDisturbNetViewModel.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHAntiDisturbNetViewModel : NSObject

- (void)callAgentWithPhoneText:(NSString *)phoneText super:(UIViewController *)superVC code:(NSString *)code;

@end
