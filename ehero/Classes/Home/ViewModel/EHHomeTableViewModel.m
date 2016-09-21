//
//  EHHomeTableViewModel.m
//  ehero
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeTableViewModel.h"
#import "EHHomeAgentCell.h"
#import "EHEverydayhouseCell.h"
#import "EHTipsViewController.h"
#import "EHEverydayHouseViewController.h"
#import "EHAntidisturbViewController.h"
#import "EHWechatGroupViewController.h"
#import "EHCommentAgentViewController.h"
#import "EHHouseDetailViewController.h"
#import <MJExtension.h>
#import "EHTipsRecommend.h"
#import "YTNetCommand.h"

#import "UIImageView+WebCache.h"
#import "EHOfficialAccountController.h"
#import "EHTipsReaderViewController.h"

@implementation EHHomeTableViewModel
{
    NSMutableArray *tipsRecommendArr;
  //  NSMutableArray *imgUrlArray;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

#pragma mark - cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  //  static NSString *reuseId = @"reuseCell";
    //第一行 4个按钮
    if (indexPath.section == 0) {
        buttonCell *cell = [buttonCell buttonCellWithTableView:tableView];
        cell.delegate = self;
        [cell setClickEvent];
        return cell;
        //第二行 锦囊
    }else{
        EHTipViewCell *cell = [EHTipViewCell tipViewCellWithTableView:tableView];
        cell.pageFlowView.delegate = self;
        cell.pageFlowView.dataSource = self;
        cell.delegate = self;
        [cell setClickEvent];
        [RACObserve(self, netImageFlag)subscribeNext:^(id x) {
            [cell.pageFlowView reloadData];
            NSLog(@"reload in model");
        }];
        
        return cell;
    }
    
}


#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return ScreenWidth * 0.246875;
    }else{
        return ScreenHeight *0.47;
    }
}
#pragma mark -tableviewDelegate

- (void)firstBtnClick:(UITableViewCell *)cell{

    EHTipsViewController  *tipsViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"TipsViewController"];
    
    [self.superVC.navigationController pushViewController:tipsViewController animated:YES];
    
}

- (void)secondBtnClick:(UITableViewCell *)cell{
    
    EHAntidisturbViewController *antidisturbViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"AntidisturbViewController"];
    [self.superVC.navigationController pushViewController:antidisturbViewController animated:YES];
    
}

- (void)thirdBtnClick:(UITableViewCell *)cell{
    EHEverydayHouseViewController *everydayHouseViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"EverydayHouseViewController"];
    [self.superVC.navigationController pushViewController:everydayHouseViewController animated:YES];
}

- (void)fourthBtnClick:(UITableViewCell *)cell{
    EHWechatGroupViewController *wechatGroupViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"WechatGroupDetailViewController"];
    [self.superVC.navigationController pushViewController:wechatGroupViewController animated:YES];
    
}

- (void)moreClick:(UITableViewCell *)cell{
    EHTipsViewController  *tipsViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"TipsViewController"];
    
    [self.superVC.navigationController pushViewController:tipsViewController animated:YES];
}

- (void)guessClick:(UITableViewCell *)cell{
//    NSLog(@"guess");
//   [MBProgressHUD showNormalMessage:@"敬请期待" toView:_superVC.view];
}


#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {

    return CGSizeMake(ScreenWidth * 0.4, ScreenHeight * 0.36);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    EHTipsRecommend *tip = _tipsRecommendArray[subIndex];
    EHTipsReaderViewController *tipsReaderVC = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"TipsReaderViewController"];
    tipsReaderVC.tipsRecomnend = tip;
    [self.superVC.navigationController pushViewController:tipsReaderVC animated:YES];
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {

    return self.imageUrlStrArray.count;

}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0 , ScreenWidth * 0.4, ScreenHeight * 0.36)];
        bannerView.layer.cornerRadius = 1;
        bannerView.layer.masksToBounds = YES;
        bannerView.backgroundColor = [UIColor whiteColor];
    }
    //根据url下载网络图片
    bannerView.mainImageView.image = [YTNetCommand downloadImageWithImgStr:
                                      [self.imageUrlStrArray objectAtIndex:index] placeholderImageStr:@"home_placeholder" imageView:bannerView.mainImageView];
    //标题
    EHTipsRecommend *tip = self.tipsRecommendArray[index];
    bannerView.titleLabel.text = tip.name;
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {

 //   NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}


- (NewPagedFlowView *)flowView{
    if (!_flowView) {
        _flowView = [[NewPagedFlowView alloc]init];
    }
    return _flowView;
}

@end
