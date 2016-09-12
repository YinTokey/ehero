//
//  EHHousesInfo.h
//  易房好介
//
//  Created by Mac on 16/9/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHHousesInfo : NSObject
/**
 *  id (一个字典对象)
 */
@property(nonatomic,strong)id _id;
/**
 *  处理后的字符串形式的id
 */
@property(nonatomic,copy)NSString *idStr;

@property(nonatomic,copy)NSString *area;

@property(nonatomic,copy)NSString *clicks;

@property(nonatomic,copy)NSString *created_at;

@property(nonatomic,copy)NSString *descriptions;

@property(nonatomic,copy)NSString *floor;

@property(nonatomic,copy)NSString *followers;

@property(nonatomic,copy)NSString *location;

@property(nonatomic,copy)NSString *model;

@property(nonatomic,copy)NSString *price;

@property(nonatomic,copy)NSString *thumbs;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *toward;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *unit_price;

@property(nonatomic,copy)NSString *updated_at;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)CGFloat cellHeight;

@end
