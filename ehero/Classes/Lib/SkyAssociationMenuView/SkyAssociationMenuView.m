//
//  SkyAssociationMenuView.m
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "SkyAssociationMenuView.h"

NSString *const IDENTIFIER = @"CELL";

@interface SkyAssociationMenuView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSArray *tables;
    UIView *bgView;
    CGFloat cancelAreaY;
    NSInteger globalIdx_1,globalIdx_2;
      NSIndexPath __block *indexPathSel;
}
@end

@implementation SkyAssociationMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化选择项
        for(int i=0; i!=2; ++i) {
            sels[i] = -1;
        }
        self.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.userInteractionEnabled = YES;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = self.frame;
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        // 初始化菜单
        tables = @[[[UITableView alloc] init], [[UITableView alloc] init] ];
        [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
            [table registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER ];
            table.dataSource = self;
            table.delegate = self;
            table.frame = CGRectMake(0, 0, 0, SCREEN_HEIGHT * 3 / 5);
            table.backgroundColor = RGB(241, 243, 245);
            table.tableFooterView = [UIView new];
            cancelAreaY = table.frame.size.height;
        }];
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f];
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        bgView.userInteractionEnabled = YES;
        [bgView addSubview:[tables objectAtIndex:0]];
        [bgView addGestureRecognizer:singleTap];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender

{
    CGPoint point = [sender locationInView:self];
    UITableView *table1 = [tables objectAtIndex:0];
    if (point.y > table1.frame.origin.y + table1.frame.size.height + 60) {
        [self dismiss];
    }
}


#pragma mark private
/**
 *  调整表视图的位置、大小
 */
- (void)adjustTableViews{
    int w = SCREEN_WIDTH;
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        rect.size.height = SCREEN_HEIGHT * 3 / 5;
        t.frame = rect;
       // if(t.superview)
        showTableCount = 2;
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [tables objectAtIndex:i];
        CGRect f = t.frame;
        if (i == 0) {
            f.size.width = w;
            t.backgroundColor = RGB(241, 243, 245);
            t.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            f.size.width = w / showTableCount;
            t.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            t.separatorColor = [UIColor lightGrayColor];
            t.backgroundColor = [UIColor whiteColor];
        }
        f.origin.x = f.size.width * i;
        t.frame = f;
    }
}
/**
 *  取消选择
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel)]) {
        [self.delegate assciationMenuViewCancel];
    }
}

/**
 *  保存table选中项
 */
#pragma mark - 点击回调，可以在这设置代理
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
        //选择菜单1
        if (idx == 0) {
            if([self.delegate respondsToSelector:@selector(menuDidSelectedAtIndex1:idxInClass1:)]) {
                [self.delegate menuDidSelectedAtIndex1:self idxInClass1:idx];
                indexPathSel = [t indexPathForSelectedRow];
                
            }
        //选择菜单2
        }else{
            if([self.delegate respondsToSelector:@selector(menuDidSelectedAtIndex2:idxInClass2:)]) {
                [self.delegate menuDidSelectedAtIndex2:self idxInClass2:idx];
            }
        }
    }];
}

- (void)saveSelTable1{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
        //选择菜单1
        if (idx == 0) {
            if([self.delegate respondsToSelector:@selector(menuDidSelectedAtIndex1:idxInClass1:)]) {
                [self.delegate menuDidSelectedAtIndex1:self idxInClass1:idx];
                indexPathSel = [t indexPathForSelectedRow];
            }
        }
    }];
}


/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:sels[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if((sels[i] != -1 && !t.superview) || !i) {
            [bgView addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 {
    sels[0] = idx_1;
    sels[1] = idx_2;

}

- (void)showAsDrawDownView:(UIView *)view {
 //   CGRect showFrame = view.frame;
    CGFloat x = 0.f;
  //  CGFloat y = showFrame.origin.y+showFrame.size.height;
    CGFloat y = 64; //64是状态栏高度＋导航栏高度
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = SCREEN_HEIGHT-y;
    bgView.frame = CGRectMake(x, y, w, h);
    if(!bgView.superview) {
        [self addSubview:bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
}

- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            [bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark UITableViewDateSourceDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if(tableView == [tables objectAtIndex:0]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:indexPath.row];
        cell.backgroundColor = RGB(241, 243, 245);
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        
    }else{
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger __block count;
  
    [tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == tableView) {
            //表1的行数
            if (idx == 0) {
                count = [_delegate assciationMenuView:self countForClass:idx numberForClass_1:0];
   
                *stop = YES;
            //表2的行数
            }else{
                count = [_delegate assciationMenuView:self countForClass:idx numberForClass_1:indexPathSel.row];
            
                *stop = YES;
            }
            //*stop = YES;
        }
    }];
    return count;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    BOOL isNexClass = true;
    if(tableView == t0){
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
            globalIdx_1 = indexPath.row;
        }
        if(isNexClass) {
            [t1 reloadData];
            if(!t1.superview) {
                [bgView addSubview:t1];
            }
          //  [self saveSels];
            [self saveSelTable1];
            [self adjustTableViews];
        }else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            [self dismiss];
           
        }
    }else if(tableView == t1) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
            globalIdx_2 = indexPath.row;
            
        }
        if(isNexClass){

            [self adjustTableViews];
        }else{

            [self saveSels];
            [self dismiss];
        }
    
    }
}

@end
