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
    
    CGFloat mobileW = 90;
    CGFloat mobileH = 20;
    CGFloat mobileX = 50;
    CGFloat mobileY = 25;
    _mobileFrame = CGRectMake(mobileX, mobileY, mobileW, mobileH);
    
    _starFrame = CGRectMake(mobileX + mobileW + 10, mobileY, 25, 25);
    
    //内容
    CGSize textSize =  [commentInfo.text sizeWithMaxSize:CGSizeMake(200, MAXFLOAT) fontSize:13];

    CGSize buttonSize = CGSizeMake(textSize.width + 20 * 2, textSize.height + 20 * 2);
    CGFloat textY = CGRectGetMaxY(_mobileFrame);
    CGFloat textX = CGRectGetMaxX(_mobileFrame) + margin;
    _textFrame = (CGRect){{textX,textY},buttonSize};
    
    //_communityFrame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    // 小区
    
    // 时间
    
    //计算行高
    CGFloat mobileMaxY = CGRectGetMaxY(_mobileFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    
    _rowHeight = mobileMaxY + textMaxY + margin;
    
}

@end
