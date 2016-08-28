//
//  EHSlides.h
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"
@interface EHSlides : JKDBModel

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *href;

@end
