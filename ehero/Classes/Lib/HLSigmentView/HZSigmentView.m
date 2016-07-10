//
//  HZSigmentView.m
//  HZSigmentView
//
//  Created by 王会洲 on 16/5/26.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "HZSigmentView.h"
/**
 *  16进制颜色
 */
#define HLHEXCOLOR(str) [UIColor colorWithHexString:str]
@interface HZSigmentView()
// 高度
@property (nonatomic, assign) CGFloat  menuHeight;


@property (nonatomic,strong) NSMutableArray * btnArrys;

@property (nonatomic,strong) UIButton * titleBtn;
@property (nonatomic,strong) UIScrollView * BackScrollView;
@property (nonatomic,strong) UIView * bottomLine;
@property (nonatomic,assign) CGFloat btnWidth;

@end

@implementation HZSigmentView


-(instancetype)initWithOrgin:(CGPoint)origin andHeight:(CGFloat)height {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, DDMWIDTH, height)];
    if (self) {
        self.menuHeight = height;
        self.defaultIndex = 1;
        
        self.titleFont = [UIFont systemFontOfSize:15];
        self.btnArrys = [[NSMutableArray alloc] initWithCapacity:0];
        self.titleNomalColor = DDMColor(80, 80, 80);
        self.titleSelectColor = DDMColor(30, 137, 255);
        self.BackScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DDMWIDTH, self.frame.size.height)];
        self.BackScrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.BackScrollView];

        
        [self registerForKVO];
        
        //检测滚动
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionScroll:) name:@"HLGoodsDetailCellCollectionScroll" object:nil];
    }
    return self;
}

- (void)collectionScroll:(NSNotification *)obj {
    NSLog(@"%d", [obj.object intValue]);
    UIButton *button = [self viewWithTag:[obj.object intValue]];
    
    [self btnTitleClick:button];
}

-(void)registerForKVO {
    //[self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    //[self addObserver:self forKeyPath:@"titleFont" options:NSKeyValueObservingOptionNew context:nil];
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects: @"titleNomalColor", @"titleSelectColor", @"titleFont", @"defaultIndex", nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self updateUIForKeypath:keyPath];
   
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if([keyPath isEqualToString:@"titleNomalColor"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            [btn setTitleColor:self.titleNomalColor forState:UIControlStateNormal];
        }];
    }else if([keyPath isEqualToString:@"titleSelectColor"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            [btn setTitleColor:self.titleSelectColor forState:UIControlStateSelected];
        }];
    }else if([keyPath isEqualToString:@"titleFont"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            [btn.titleLabel setFont:self.titleFont];
        }];
        
    }else if([keyPath isEqualToString:@"defaultIndex"])
    {
        [self updaeViewUI:^(UIButton *btn) {
            if (btn.tag-1 == self.defaultIndex-1) {
                self.titleBtn=btn;
                btn.selected=YES;
            }else{
                btn.selected=NO;
            }
        }];
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
}


-(void)updaeViewUI:(void(^)(UIButton * btn))complated {
    for (UIButton *btn in self.btnArrys) {
        [btn setTitleColor:self.titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=self.titleFont;
        
        if (complated) {
           complated(btn);
        }
        

    }
}

-(void)dealloc {
    [self unregisterFromKVO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}


-(void)setTitleArry:(NSArray *)titleArry {
    if (!titleArry) return;
    
    _titleArry = titleArry;
    if (_titleArry.count < 6) {
        self.btnWidth = DDMWIDTH / _titleArry.count;
    }else{
        self.btnWidth = DDMWIDTH / 5;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.menuHeight - .5, self.btnWidth * _titleArry.count, .5)];
    line.backgroundColor = [UIColor orangeColor];
    [self.BackScrollView addSubview:line];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake((self.btnWidth - 50) / 2 + (self.defaultIndex - 1) * self.btnWidth, self.menuHeight-2, 50, 2)];
    self.bottomLine.backgroundColor =  [UIColor redColor];
    [self.BackScrollView addSubview:self.bottomLine];
    
    // 重置横线位置
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomLine.frame = CGRectMake((self.btnWidth - 50) / 2  + (self.defaultIndex - 1) * self.btnWidth, self.menuHeight-2, 50, 2);
    }];
    
    self.BackScrollView.contentSize = CGSizeMake(self.btnWidth * _titleArry.count, self.menuHeight);
    
    
    for (int i=0; i<_titleArry.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.btnWidth * i, 0, self.btnWidth, self.menuHeight-2);
        btn.tag = i+1;
        [btn setTitle:_titleArry[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnTitleClick:) forControlEvents:UIControlEventTouchDown];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = _titleFont;
        [self.BackScrollView addSubview:btn];
        
        [self.btnArrys addObject:btn];
        if (i == self.defaultIndex - 1) {
            _titleBtn = btn;
            btn.selected = YES;
        }
        
    }
}
#pragma mark - title点击事件
-(void)btnTitleClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segment:didSelectColumnIndex:)]) {
        [self.delegate segment:self didSelectColumnIndex:sender.tag];
    }
    
    if (sender.tag == self.defaultIndex) {
        return;
    }else{
        self.titleBtn.selected = NO;
        sender.selected = YES;
        self.titleBtn = sender;
        self.defaultIndex = sender.tag;
    }
    
    //计算偏移量
    CGFloat offsetX = sender.frame.origin.x - 2 * self.btnWidth;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= self.BackScrollView.contentSize.width-DDMWIDTH;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        [self.BackScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        self.bottomLine.frame=CGRectMake(sender.frame.origin.x + (sender.frame.size.width - 50) / 2, self.frame.size.height-2, 50, 2);
        
    } completion:^(BOOL finished) {
        
    }];
}
@end
