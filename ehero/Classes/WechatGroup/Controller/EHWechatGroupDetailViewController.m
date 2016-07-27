//
//  EHWechatGroupDetailViewController.m
//  ehero
//
//  Created by Mac on 16/7/26.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHWechatGroupDetailViewController.h"

@interface EHWechatGroupDetailViewController ()
{
    NSTimer*_timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImgView;

@end

@implementation EHWechatGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILongPressGestureRecognizer*longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(dealLongPress:)];
    [_QRCodeImgView addGestureRecognizer:longPress];
    
    //5.定时器
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(create) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark-> 长按识别二维码
-(void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    if(gesture.state==UIGestureRecognizerStateBegan){
        
     //   _timer.fireDate=[NSDate distantFuture];
        
        UIImageView*tempImageView=(UIImageView*)gesture.view;
        if(tempImageView.image){
            //1. 初始化扫描仪，设置设别类型和识别质量
            CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
            //2. 扫描获取的特征组
            NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImageView.image.CGImage]];
            //3. 获取扫描结果
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        
    }else if (gesture.state==UIGestureRecognizerStateEnded){
        
        
       // _timer.fireDate=[NSDate distantPast];
    }
    
    
}



@end
