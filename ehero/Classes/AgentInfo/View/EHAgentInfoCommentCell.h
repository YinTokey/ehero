//
//  EHAgentInfoCommentCell.h
//  ehero
//
//  Created by Mac on 16/7/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHCommentInfo.h"
@protocol agentInfoCommentCellDelegate<NSObject>
@optional
- (void)niceClick:(UITableViewCell *)cell;
- (void)commonClick:(UITableViewCell *)cell;
- (void)badClick:(UITableViewCell *)cell;

@end


@interface EHAgentInfoCommentCell : UITableViewCell

+ (instancetype)AgentInfoCommentCellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *niceTriangle;
@property (weak, nonatomic) IBOutlet UIImageView *commonTriagle;
@property (weak, nonatomic) IBOutlet UIImageView *badTriangle;

@property (weak, nonatomic) IBOutlet UIButton *highComment;
@property (weak, nonatomic) IBOutlet UIButton *midComment;
@property (weak, nonatomic) IBOutlet UIButton *lowComment;

@property (nonatomic,strong)NSMutableArray *commentsArray;

- (void)setCommentCounts;
- (void)setClickEvent;
@property (nonatomic,weak)id<agentInfoCommentCellDelegate>delegate;


@end
