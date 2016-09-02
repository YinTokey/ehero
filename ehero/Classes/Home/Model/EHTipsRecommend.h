//
//  EHTipsRecommend.h
//  ehero
//
//  Created by Mac on 16/9/1.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

@interface EHTipsRecommend : JKDBModel

/**
 *  id (一个字典对象)
 */
@property(nonatomic,strong)id _id;
/**
 *  处理后的字符串形式的id
 */
@property(nonatomic,copy)NSString *idStr;

@property(nonatomic,copy)NSString *author;

@property(nonatomic,copy)NSString *available;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *clicks;

@property(nonatomic,copy)NSString *created_at;

@property(nonatomic,copy)NSString *district;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *route;

@property(nonatomic,copy)NSString *thumb;

@property(nonatomic,copy)NSString *updated_at;

@property(nonatomic,copy)NSString *version;

//把 _id转化为 idStr
- (void)getIdStringFromDictionary;

@end
