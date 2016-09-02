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
#import "EHTipsViewCell.h"
#import <MJExtension.h>
#import "EHTipsRecommend.h"
#import "YTNetCommand.h"

#import "UIImageView+WebCache.h"
#import "EHOfficialAccountController.h"


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
        EHTipsViewCell *cell = [EHTipsViewCell tipsViewCellWithTableView:tableView];
        cell.pageFlowView.delegate = self;
        cell.pageFlowView.dataSource = self;
        
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
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 1) {
//        EHCommentAgentViewController *commentAgentViewController = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"CommentAgentViewController"];
//        [self.superVC.navigationController pushViewController:commentAgentViewController animated:YES];
//    }
//}


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

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {

    return CGSizeMake(ScreenWidth * 0.4, ScreenHeight * 0.37);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    EHTipsRecommend *tip = _tipsRecommendArray[subIndex];
    EHOfficialAccountController *officialAccountVC = [[self.superVC storyboard]instantiateViewControllerWithIdentifier:@"OfficialAccountController"];
    officialAccountVC.tipsRecomnend = tip;
    [self.superVC.navigationController pushViewController:officialAccountVC animated:YES];
    //NSLog(@"%@",tip.name);
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {

    return self.imageUrlStrArray.count;

}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 84, 300)];
        bannerView.layer.cornerRadius = 1;
        bannerView.layer.masksToBounds = YES;
        bannerView.backgroundColor = [UIColor whiteColor];
    }
    //根据url下载网络图片
    bannerView.mainImageView.image = [YTNetCommand downloadImageWithImgStr:
                                      [self.imageUrlStrArray objectAtIndex:index] placeholderImageStr:@"home_placeholder" imageView:bannerView.mainImageView];

    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {

    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

//- (void)getTipsInfo{
//
//    [YTHttpTool get:TipsRecommendUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
//        tipsRecommendArr = [EHTipsRecommend mj_objectArrayWithKeyValuesArray:responseObj];
//        for (EHTipsRecommend *tipsR in tipsRecommendArr) {
//            [self.imageUrlStrArray addObject:tipsR.thumb];
//        }
//        NSLog(@"urls %@",self.imageUrlStrArray);
//   
//    } failure:^(NSError *error) {
//        NSLog(@"failure");
//    }];
//}

- (NewPagedFlowView *)flowView{
    if (!_flowView) {
        _flowView = [[NewPagedFlowView alloc]init];
    }
    return _flowView;
}

@end
