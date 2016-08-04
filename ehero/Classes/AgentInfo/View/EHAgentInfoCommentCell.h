//
//  EHAgentInfoCommentCell.h
//  ehero
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHAgentInfoCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *commentView;

+ (instancetype)AgentInfoCommentCellWithTableView:(UITableView *)tableView;


@end
