//
//  EHLabel.m
//  易房好介
//
//  Created by Mac on 16/9/24.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHLabel.h"

@implementation EHLabel



-(void) drawTextInRect:(CGRect)rect {
    //从将文本的绘制Rect宽度缩短半个字体宽度
    //self.font.pointSize / 2
    return [super drawTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - self.font.pointSize / 2, rect.size.height)];
}

@end
