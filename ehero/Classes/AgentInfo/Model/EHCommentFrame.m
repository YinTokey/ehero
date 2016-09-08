//
//  EHCommentFrame.m
//  易房好介
//
//  Created by Mac on 16/9/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHCommentFrame.h"
#import "NSString+Extension.h"
#import "EHCommentInfo.h"

@implementation EHCommentFrame


//重写set方法
- (void)setCommentInfo:(EHCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    CGFloat margin = 10;
    
    CGFloat authorX = 20;
    CGFloat authorY = 10;
    CGFloat authorW = 90;
    CGFloat authorH = 25;
    _authorFrame = CGRectMake(authorX, authorY, authorW, authorH);
    
    _starFrame = CGRectMake(authorX + authorW , authorY + 2 , 20, 20);
    
    //内容
    CGSize textSize =  [commentInfo.text sizeWithMaxSize:CGSizeMake(200, MAXFLOAT) fontSize:13];

    CGSize buttonSize = CGSizeMake(ScreenWidth - 40, textSize.height);
    CGFloat textY = authorY + authorH;
    CGFloat textX = authorX;
    _textFrame = (CGRect){{textX,textY},buttonSize};
    
    //_communityFrame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    // 小区
    
    // 时间
    
    //计算行高
    CGFloat authorMaxY = CGRectGetMaxY(_authorFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    
    //背景
    CGSize backgroundSize = CGSizeMake(ScreenWidth - 20, buttonSize.height + authorH + 10);
    _backgroundFrame = (CGRect){{textX - 10, _superCell.frame.origin.y + 3},backgroundSize};
    
    CGFloat backgroudMaxY = _backgroundFrame.size.height + 2 * 10 ;
    
    
    _rowHeight =  backgroudMaxY;
    
}

@end
