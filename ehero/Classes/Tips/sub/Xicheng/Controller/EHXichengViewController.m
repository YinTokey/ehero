//
//  EHXichengViewController.m
//  易房好介
//
//  Created by Mac on 16/9/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHXichengViewController.h"
#import "EHXichengTipCell.h"
#import "EHTipsReaderViewController.h"
@interface EHXichengViewController ()

@end

@implementation EHXichengViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = RGB(238, 245, 250);
    self.collectionView.alwaysBounceVertical = YES ;
}


#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    CGFloat cellWidth = self.view.frame.size.width/2 - 18 * 3;
    CGFloat cellHight = self.view.frame.size.height/3 ;
    
    return CGSizeMake(cellWidth, cellHight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    CGFloat cellWidth = self.view.frame.size.width/2 - 18 * 3;
    CGFloat cellHight = self.view.frame.size.height/3 ;
    
    return UIEdgeInsetsMake(10, (ScreenWidth - 2 * cellWidth)/3, 15, (ScreenWidth - 2 * cellWidth)/3);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _tipsRecommendArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EHXichengTipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EHTipsRecommend *tip = _tipsRecommendArray[indexPath.row];
    EHTipsReaderViewController *tipsReaderVC = [sb instantiateViewControllerWithIdentifier:@"TipsReaderViewController"];
    tipsReaderVC.tipsRecomnend = tip;
    [self.navigationController pushViewController:tipsReaderVC animated:YES];

}

@end
