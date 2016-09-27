//
//  EHWechatGroupDetailViewController.m
//  ehero
//
//  Created by Mac on 16/7/26.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHWechatGroupDetailViewController.h"
#import <Photos/Photos.h>
#import "MBProgressHUD+YT.h"

/** 相册名字 */
static NSString * const XMGCollectionName = @"易房好介-Photos";

@interface EHWechatGroupDetailViewController ()
{
    NSTimer*_timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
- (IBAction)toWechatClick:(id)sender;

@end

@implementation EHWechatGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(234, 243, 248);
    [self loadQRImage];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (IBAction)toWechatClick:(id)sender {
    [self savePhoto];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self toWechat];
    });
    
}

- (void)toWechat{
    // 1.创建要打开的App的URL
    NSURL *weixinURL = [NSURL URLWithString:@"weixin://timeline"];
    
    // 2.判断是否该URL可以打开
    if ([[UIApplication sharedApplication] canOpenURL:weixinURL]) {
        
        // 3.打开URL
        [[UIApplication sharedApplication] openURL:weixinURL];
    }

}

- (void)savePhoto{
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error = nil;
            // 保存相片到相机胶卷
            __block PHObjectPlaceholder *createdAsset = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:self.QRCodeImgView.image].placeholderForCreatedAsset;
            } error:&error];
            
            if (error) {
                [MBProgressHUD showError:@"保存失败" toView:self.view];
                //[self.view makeToast:@"保存失败" duration:1.0 position:CSToastPositionCenter];
                return;
            }
            
            // 拿到自定义的相册对象
            PHAssetCollection *collection = [self collection];
            if (collection == nil) return;
            
            [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
                [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection] insertAssets:@[createdAsset] atIndexes:[NSIndexSet indexSetWithIndex:0]];
            } error:&error];
            
            if (error) {
                [MBProgressHUD showError:@"保存失败" toView:self.view];
            } else {
                [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            }
        });
    }];
}

/**
 * 获得自定义的相册对象
 */
- (PHAssetCollection *)collection
{
    // 先从已存在相册中找到自定义相册对象
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:XMGCollectionName]) {
            return collection;
        }
    }
    
    // 新建自定义相册
    __block NSString *collectionId = nil;
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:XMGCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) {
        [MBProgressHUD showError:@"获取相册失败" toView:self.view];
        NSLog(@"获取相册【%@】失败", XMGCollectionName);
        return nil;
    }
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].lastObject;
}

- (void)loadQRImage{
    [LBProgressHUD showHUDto:self.view animated:NO];
    [YTHttpTool get:wechatGroupUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObj) {
        NSArray *arr  = [NSJSONSerialization JSONObjectWithData:responseObj options:kNilOptions error:nil] ;
        NSDictionary *dic  = [arr firstObject];
        NSString *qrcode = [dic objectForKey:@"qrcode"];
        self.QRCodeImgView.image = [YTNetCommand downloadImageWithImgStr:qrcode placeholderImageStr:nil imageView:self.QRCodeImgView];
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    } failure:^(NSError *error) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        [MBProgressHUD showError:@"请求数据失败" toView:self.view];
    }];

}
@end
