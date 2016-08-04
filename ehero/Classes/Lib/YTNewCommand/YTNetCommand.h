//
//  YTNetCommand.h
//  每日烹
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YTNetCommand : NSObject

@property (nonatomic,strong) NSArray *keywordsArr;



+(UIImage *)downloadImageWithImgStr:(NSString *)imgUrlStr
                placeholderImageStr:(NSString *)placeholderImageStr
                          imageView:(UIImageView *)imageView;


@end
