//
//  EHAsiaViewController.m
//  ehero
//
//  Created by Mac on 16/7/16.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHaidianViewController.h"
#import "EHTipsCell.h"
#import "EHTipsRecommend.h"

@interface EHHaidianViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *tipsArray;

@end

@implementation EHHaidianViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = RGB(238, 245, 250);
    self.collectionView.alwaysBounceVertical = YES ;
    

}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];

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
    
    EHTipsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    EHTipsRecommend *tip = _tipsRecommendArray[indexPath.row];
    cell.title.text = tip.name;
    cell.thumb.image = [YTNetCommand downloadImageWithImgStr:tip.thumb placeholderImageStr:@"home_placeholder"  imageView:cell.thumb];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self.collectionView reloadData];
    NSLog(@"gsa");
}


@end
