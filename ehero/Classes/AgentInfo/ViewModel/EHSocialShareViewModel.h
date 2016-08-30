//
//  EHSocialShareViewModel.h
//  ehero
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHSocialShareViewModel : NSObject

- (void)shareWithIndex:(NSInteger)index;


@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,assign) BOOL shareToQzoneFlag;



@end
