//
//  YTSearchBar.m
//  仿搜狗阅读
//
//  Created by Mac on 16/6/3.
//  Copyright © 2016年 YinTokey. All rights reserved.
//

#import "YTSearchBar.h"

@interface YTSearchBar () <UISearchBarDelegate>

@end


@implementation YTSearchBar

+ (YTSearchBar *)searchBarWithPlaceholder:(NSString *)placeholder Frame:(CGRect )frame {
    YTSearchBar *searchBar = [[YTSearchBar alloc] initWithFrame:frame];
    searchBar.delegate = searchBar;
    searchBar.placeholder = placeholder;
    searchBar.tintColor = [UIColor blackColor];
    // [searchBar setImage:[UIImage imageNamed:@"search_sousuoicon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UIView *searchBarSub = searchBar.subviews[0];
    for (UIView *subView in searchBarSub.subviews) {
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
           // [subView setBackgroundColor:RGB(196, 30, 28)];
            //[subView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_bar"]]];
            
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
        
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subView;
            textField.textColor = [UIColor grayColor];
            [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
            textField.borderStyle = UITextBorderStyleNone;
        }
    }

    
    return searchBar;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    !self.searchBarShouldBeginEditingBlock ? : self.searchBarShouldBeginEditingBlock();
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    !self.searchBarTextDidChangedBlock ? : self.searchBarTextDidChangedBlock();
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    !self.searchBarDidSearchBlock ? : self.searchBarDidSearchBlock();
}


@end
