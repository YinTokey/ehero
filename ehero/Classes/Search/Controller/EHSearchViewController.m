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
#import "EHAgentInfoController.h"
#import "AFNetworking.h"
#import <MJExtension.h>
#import "EHAgentInfo.h"
#import "YTHttpTool.h"
#import "EHNetBusinessManager.h"
#import "MBProgressHUD+YT.h"
#import "EHSearchBar.h"

#define searchbar_width _mysearchBar.frame.size.width
#define searchbar_height _mysearchBar.frame.size.height

@interface EHSearchViewController ()<UITextFieldDelegate,EHNetBusinessManagerDelegate,EHSearchResultCellDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mysearchBar;
@property (nonatomic,strong) NSMutableArray *searchResultArr;

@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation EHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGB(241, 243, 245);

    [self setupSearchBar];
    [self addGesture];
    [YTHttpTool netCheck];

    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@"返回"];

    NSLog(@"%@",[EHAgentInfo findFirstByCriteria:@"where name = 赵洪涛"]);
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _searchResultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];
    EHAgentInfo *agentInfo = self.searchResultArr[indexPath.row];
    cell.isdrawRect = YES;
    [cell setResultCell:agentInfo];
    cell.delegate = self;
    return cell;
}
#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

#pragma mark - 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EHAgentInfoController *agentInfoVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"AgentInfoController"];
    EHAgentInfo *agentInfo = self.searchResultArr[indexPath.row];
    [agentInfo getIdStringFromDictionary];
    
    agentInfoVC.agentInfo = agentInfo;
    
    [self.navigationController pushViewController:agentInfoVC animated:YES];
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    NSLog(@"begin edit");
}


#pragma mark - 编辑完成，点击搜索时调用代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.searchResultArr removeAllObjects];
    [self searchClick];
    [self.mysearchBar resignFirstResponder ];
    return YES;
}


#pragma mark  -- UITapGestureRecognizer
- (void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [self.mysearchBar resignFirstResponder];
}


- (void)setupSearchBar{

    EHSearchBar *search = [[EHSearchBar alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth, 30)];
    search.clipsToBounds = YES;
    self.mysearchBar = search;
    self.navigationItem.titleView = _mysearchBar;
    self.mysearchBar.delegate = self;
    [self.mysearchBar becomeFirstResponder];
}


- (void)addGesture{
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

}

# pragma mark － 搜索点击
- (void)searchClick{
    [LBProgressHUD showHUDto:self.view animated:NO];
    
    NSString *keyword = self.mysearchBar.text;
    //搜索地区
    NSDictionary *param =@{@"address":keyword};
    [self searchWithURLString:searchAreaUrlStr Param:param];

}
# pragma mark - 搜索方法
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
#pragma mark - 搜索结果检测
- (void)searchStatusTest{
    
    if (_searchResultArr.count == 0) {
        [self.view makeToast:@"没有找到经纪人" duration:1.0 position:CSToastPositionCenter];
    }else{
        [self.view makeToast:@"为您找到经纪人" duration:1.0 position:CSToastPositionCenter];
    }
}

- (void)callBtnClick:(UITableViewCell *)cell{
    NSLog(@"在控制器里点击");
    
}




@end
