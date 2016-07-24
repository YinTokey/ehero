//
//  EHSearchViewController.m
//  ehero
//
//  Created by Mac on 16/7/8.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHSearchViewController.h"
#import "YTSearchBar.h"
#import "UIBarButtonItem+Extension.h"
#import "EHSearchResultCell.h"
#import "EHAgentInfoViewController.h"
#import "AFNetworking.h"
#import <MJExtension.h>
#import "EHAgentInfo.h"
#import "YTHttpTool.h"
#import "EHNetBusinessManager.h"

@interface EHSearchViewController ()<UITextFieldDelegate,EHNetBusinessManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mysearchBar;
@property (nonatomic,strong) NSMutableArray *searchResultArr;

@end

@implementation EHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    
    [self addGesture];
    
    [YTHttpTool netCheck];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _searchResultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
    EHAgentInfo *agentInfo = self.searchResultArr[indexPath.row];
    [cell setResultCell:agentInfo];
    return cell;
}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124;
}

#pragma mark - 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHAgentInfoViewController *agentInfoVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"AgentInfoViewController"];
    [self.navigationController pushViewController:agentInfoVC animated:YES];
}

#pragma mark - 编辑完成，点击搜索时调用代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.searchResultArr removeAllObjects];
    [self searchClick];
    [self.mysearchBar resignFirstResponder ];
    
    return YES;
}

#pragma mark  -- UITapGestureRecognizer
-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.mysearchBar resignFirstResponder];
    
}


- (void)setupSearchBar{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_bar"]];
    self.mysearchBar.background = [UIImage imageNamed:@"search_bar"];
    self.mysearchBar.leftViewMode = UITextFieldViewModeAlways;
    self.mysearchBar.delegate = self;
    self.mysearchBar.placeholder = @"shini shge shaib";
    
    
}


- (void)addGesture{
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

}


- (void)searchClick{
    [LBProgressHUD showHUDto:self.view animated:NO];
    
    NSString *keyword = self.mysearchBar.text;
    //搜索地区
    NSDictionary *param =@{@"address":keyword};
    [self searchWithURLString:searchAreaUrlStr Param:param];

}

- (void)searchWithURLString:(NSString *)urlString Param:(NSDictionary *)param{

    [YTHttpTool get:urlString params:param success:^(id responseObj) {
        //json转模型
        self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObj];
        
        [self searchStatusTest];
        
        [self.tableView reloadData];
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}

- (void)searchStatusTest{
    
    if (_searchResultArr.count == 0) {
        [MBProgressHUD showNormalMessage:@"没有找到经纪人" showDetailText:nil toView:self.view];

    }else{
        [MBProgressHUD showNormalMessage:@"找到经纪人，正在载入数据" showDetailText:nil toView:self.view];

    }
}




@end
