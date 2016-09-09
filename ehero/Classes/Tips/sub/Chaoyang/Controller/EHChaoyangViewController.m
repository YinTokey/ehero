//
//  EHTwoViewController.m
//  ehero
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHChaoyangViewController.h"
#import "EHTipsCell.h"
@interface EHChaoyangViewController ()

@end

@implementation EHChaoyangViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"oneVC");

    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    CGFloat cellWidth = self.view.frame.size.width/2 - 5;
    CGFloat cellHight = self.view.frame.size.height/2 - 60;
    
    return CGSizeMake(cellWidth, cellHight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 5;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    EHTipsCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // cell.imgView.image = [UIImage imageNamed:@"tipsExample"];
    
    return cell;
}


@end
