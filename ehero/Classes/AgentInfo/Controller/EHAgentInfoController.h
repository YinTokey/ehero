//
//  EHAgentInfoController.h
//  ehero
//
//  Created by Mac on 16/7/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHAgentInfoController : UITableViewController
/**
 *  id
 */
@property(nonatomic,copy)NSString *idStr;
/**
 *  小区
 */
@property(nonatomic,copy)NSString *community;
/**
 *  公司
 */
@property(nonatomic,copy)NSString *company;

/**
 *  地区
 */
@property(nonatomic,copy)NSString *district;

/**
 *  电话号码
 */
@property(nonatomic,copy)NSString *mobile;
/**
 *  姓名
 */
@property(nonatomic,copy)NSString *name;
/**
 *  职位
 */
@property(nonatomic,copy)NSString *position;
/**
 *  好评率
 */
@property(nonatomic,copy)NSString *rates;
/**
 *  板块
 */
@property(nonatomic,copy)NSString *region;

/**
 *  头像url
 */
@property(nonatomic,copy)NSString *tx;



@end
