//
//  EHTipsViewController.m
//  ehero
//
//  Created by Mac on 16/7/10.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHTipsViewController.h"
#import "HZSigmentView.h"
@interface EHTipsViewController ()<HZSigmentViewDelegate>


@property (nonatomic, strong) HZSigmentView * sigment;

@end

@implementation EHTipsViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self createSigmentView];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)createSigmentView
{
    self.sigment = [[HZSigmentView alloc] initWithOrgin:CGPointMake(0, 0) andHeight:40];
    
    self.sigment.delegate = self;
    self.sigment.backgroundColor = [UIColor whiteColor];
    self.sigment.titleNomalColor = [UIColor blackColor];
    self.sigment.titleSelectColor = [UIColor orangeColor];
    self.sigment.titleFont = [UIFont systemFontOfSize:14];
    self.sigment.titleArry = @[@"热门",@"最新",@"品类",@"属性"];
    [self.collectionView addSubview:self.sigment];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark--HZSigmentViewDelegate
-(void)segment:(HZSigmentView *)sengment didSelectColumnIndex:(NSInteger)index
{
    NSString *notifStr;
    if (index == 1) {
        notifStr = @"1";
    } else if (index == 2) {
        notifStr = @"2";
    } else if (index == 3) {
        notifStr = @"3";
    } else {
        notifStr = @"4";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HLGoodsDetailControllerSigmentClick" object:notifStr];
}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
