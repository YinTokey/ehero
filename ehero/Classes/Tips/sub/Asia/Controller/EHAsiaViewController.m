//
//  EHAsiaViewController.m
//  ehero
//
//  Created by Mac on 16/7/16.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHAsiaViewController.h"
#import "EHAsiaViewCell.h"
@interface EHAsiaViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation EHAsiaViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"i am asia ");
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupCollectionView];
    
    
}

- (void)setupCollectionView{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

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

    
    EHAsiaViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
   // cell.imgView.image = [UIImage imageNamed:@"tipsExample"];
    
    return cell;
}


@end
