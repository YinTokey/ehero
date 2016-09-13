//
//  EHAgentInfoCommentCell.h
//  ehero
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHCommentInfo.h"


@interface EHAgentInfoCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *commentView;

+ (instancetype)AgentInfoCommentCellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIButton *highComment;

@property (weak, nonatomic) IBOutlet UIButton *midComment;
@property (weak, nonatomic) IBOutlet UIButton *lowComment;

@property (nonatomic,strong)NSMutableArray *commentsArray;


- (void)setCommentCounts;
@end
