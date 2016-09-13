//
//  EHCommentInfo.h
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHCommentInfo : NSObject

@property(nonatomic,strong)id _id;
/**
 *  处理后的字符串形式的id   
 */
@property(nonatomic,copy)NSString *idStr;

@property(nonatomic,copy)NSString *author;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *community;

@property(nonatomic,copy)NSString *created_at;

@property(nonatomic,copy)NSString *deleted_at;

@property(nonatomic,copy)NSString *kind;

@property(nonatomic,copy)NSString *parent;

@property(nonatomic,copy)NSString *path;

@property(nonatomic,copy)NSString *text;

@property(nonatomic,assign)CGFloat cellHeight;

- (void)getIdStringFromDictionary;

@end
