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

- (void)setCommentInfo:(EHCommentInfo *)commentInfo{
    _commentInfo = commentInfo;
    CGFloat margin = 10;
    
    CGFloat authorX = 10;
    CGFloat authorY = 10;
    CGFloat authorW = 50;
    CGFloat authorH = 25;
    _authorFrame = CGRectMake(authorX, authorY, authorW, authorH);
    
    _starFrame = CGRectMake(authorX + authorW + 10, authorY, 25, 25);
    
    //内容
    CGSize textSize =  [commentInfo.text sizeWithMaxSize:CGSizeMake(200, MAXFLOAT) fontSize:13];

    CGSize buttonSize = CGSizeMake(ScreenWidth - 20, textSize.height + 20 * 2);
    CGFloat textY = CGRectGetMaxY(_authorFrame) - 30;
    CGFloat textX = CGRectGetMaxX(_authorFrame)  - 50;
    _textFrame = (CGRect){{textX,textY},buttonSize};
    
    //_communityFrame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    // 小区
    
    // 时间
    
    //计算行高
    CGFloat mobileMaxY = CGRectGetMaxY(_authorFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    
    _rowHeight =  textMaxY + margin;
    
}

@end
