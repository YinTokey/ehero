//
//  EHOfficialViewModel.h
//  ehero
//
//  Created by Mac on 16/8/30.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

#define jsClick  @"function addImgClickEvent() { \
var imgs = document.getElementsByTagName('img'); \
for (var i = 0; i < imgs.length; ++i) { \
var img = imgs[i]; \
img.onclick = function () { \
window.location.href = 'hyb-image-preview:' + this.src; \
}; \
} \
}"

@interface EHOfficialViewModel : NSObject<WKNavigationDelegate>

@property (nonatomic,strong) UIViewController *superVC;


@end
