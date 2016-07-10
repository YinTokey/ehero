//
//  EHGuideViewController.m
//  ehero
//
//  Created by Mac on 16/7/9.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHGuideViewController.h"

@interface EHGuideViewController ()






@end


@implementation EHGuideViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    [self loadPDF];
}

- (void)loadPDF{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Socket" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
    
}

@end
