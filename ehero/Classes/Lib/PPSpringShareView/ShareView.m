//
//  ShareView.m
//  PPSpringShareView
//
//  Created by macfai on 16/2/23.
//  Copyright © 2016年 pengpeng. All rights reserved.
//

#import "ShareView.h"
#import "InnerView.h"

#define kSCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define kSCREENHEIGHT    [UIScreen mainScreen].bounds.size.height


@interface ShareView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIView *bottomShareView;
@property(nonatomic,strong)UIButton *cancelBtn;

@end

@implementation ShareView

-(id)initWithTitleArray:(NSMutableArray *)titleArray picArray:(NSMutableArray *)picArray{
    
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;

        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        
        self.bottomShareView = [[UIView alloc]initWithFrame:CGRectMake(0, kSCREENHEIGHT, kSCREENWIDTH, 130)];
        self.bottomShareView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
        [self addSubview:self.bottomShareView];
        
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 130 - 40, kSCREENWIDTH, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:RGB(68, 180, 244)];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomShareView addSubview:_cancelBtn];
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 90)];
        scrollView.contentSize = CGSizeMake((titleArray.count +3)/4*kSCREENWIDTH, 0);
        scrollView.bounces = YES;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self.bottomShareView addSubview:scrollView];
        
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.numberOfPages = (titleArray.count +3)/4;
        _pageControl.center = CGPointMake(kSCREENWIDTH/2, 80);
     //   [_bottomShareView addSubview:_pageControl];
        
        __weak typeof(self)wself = self;
        
        for (int i = 0; i<titleArray.count; i++) {
            
            InnerView *inView = [[InnerView alloc]initWithFrame:CGRectMake((kSCREENWIDTH/4)*i, 40, kSCREENWIDTH/4, 90)];
            inView.tag = 10+i;
            inView.button.tag = 100+i;
            [inView.button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArray[i]]] forState:UIControlStateNormal];
            [inView.titleLabel setText:[NSString stringWithFormat:@"%@",titleArray[i]]];
            
            [inView selectedCurrentIndex:^(NSInteger index) {
                
                [self dismiss];
                self.block(index);
            }];
            
            [scrollView addSubview:inView];
            
        }
        
        
        
        //
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:wself action:@selector(dismiss)];
        [wself addGestureRecognizer:tap];
        
    }
    
    return self;
    
}

#pragma mark - scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/kSCREENWIDTH;
}

-(void)showShareView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _bottomShareView.transform = CGAffineTransformMakeTranslation(0,  - 130);
        
        for (int i = 0; i < 8; i ++) {
            
            InnerView *iiView =  (InnerView *)[self viewWithTag:10 + i];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*0.08 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    
                    iiView.center = CGPointMake(kSCREENWIDTH/4*i  + (kSCREENWIDTH/8), 45);
                    
                } completion:nil];
                
            });
        }

        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

-(void)currentIndexWasSelected:(shareBlock)block{
    
    self.block = block;
    
}

-(void)cancelBtnClick:(UIButton *)sender{
    
    [self dismiss];
    
}

-(void)dismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        //复原
        _bottomShareView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
