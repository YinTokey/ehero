//
//  EHAsiaViewController.m
//  ehero
//
//  Created by Mac on 16/7/16.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHaidianViewController.h"
#import "EHTipsRecommend.h"
#import "EHHaidianTipCell.h"
#import "EHTipsReaderViewController.h"

@interface EHHaidianViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *tipsArray;

@end

@implementation EHHaidianViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = RGB(238, 245, 250);
    self.collectionView.alwaysBounceVertical = YES ;
    
    self.collectionView.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 55);

}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [self.collectionView reloadData];
//
//}

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
    
    EHTipsRecommend *tip = _tipsRecommendArray[indexPath.row];
  
    EHHaidianTipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.nameLabel.text = tip.name;
   NSString *realUrlStr = [tip.thumb stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    cell.thumbView.image = [YTNetCommand downloadImageWithImgStr:realUrlStr placeholderImageStr:@"home_placeholder"  imageView:cell.thumbView];

       return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    EHTipsRecommend *tip = _tipsRecommendArray[indexPath.row];
    EHTipsReaderViewController *tipsReaderVC = [sb instantiateViewControllerWithIdentifier:@"TipsReaderViewController"];
    tipsReaderVC.tipsRecomnend = tip;
    //中文url 转义
    tipsReaderVC.tipsRecomnend.route = [tipsReaderVC.tipsRecomnend.route stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [self.navigationController pushViewController:tipsReaderVC animated:YES];
}


@end
