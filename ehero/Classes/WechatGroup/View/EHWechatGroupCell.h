//
//  EHWechatGroupCell.h
//  ehero
//
//  Created by Mac on 16/7/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHWechatGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImgView;

+ (instancetype)wechatGroupCellWithTableView:(UITableView *)tableView;

@end
