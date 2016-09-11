//
//  EHXichengViewController.m
//  易房好介
//
//  Created by Mac on 16/9/11.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHXichengViewController.h"
#import "EHTipsCell.h"

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

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//
//
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EHTipsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
