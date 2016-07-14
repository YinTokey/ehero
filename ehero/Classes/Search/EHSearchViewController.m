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
#import "XTPopView.h"
#import "AFNetworking.h"
#import <MJExtension.h>
#import "EHAgentInfo.h"
#import "LBProgressHUD.h"

#import "YTHttpTool.h"
@interface EHSearchViewController ()<selectIndexPathDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectionBtn;
- (IBAction)select:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mysearchBar;
@property (nonatomic,copy) NSString *searchTypeString;
@property (nonatomic,strong) NSMutableArray *searchResultArr;

@end

@implementation EHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];

    self.searchTypeString = @"出租";
    
    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
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
    [LBProgressHUD showHUDto:self.view animated:NO];
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

#pragma mark - 实现代理方法，右上角弹窗点击事件
- (void)selectIndexPathRow:(NSInteger)index{
  
    switch (index) {
        case 0:
        {
            self.searchTypeString = @"出租";
            [self.selectionBtn setTitle:_searchTypeString forState:UIControlStateNormal];
            
        }
            break;
        case 1:
        {
            self.searchTypeString = @"买卖";
            [self.selectionBtn setTitle:_searchTypeString forState:UIControlStateNormal];
            
        }
            break;
        case 2:
        {
            self.searchTypeString = @"经纪人";
            [self.selectionBtn setTitle:_searchTypeString forState:UIControlStateNormal];
            
        }
            break;
        
        default:
            break;
    }
}


- (void)setupSearchBar{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    self.mysearchBar.leftView = imgView;
    self.mysearchBar.leftViewMode = UITextFieldViewModeAlways;
    self.mysearchBar.delegate = self;
    
}

- (void)setupPopView{
    CGPoint point = CGPointMake(_selectionBtn.center.x,_selectionBtn.center.y + 45);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:70 Height:40 * 3 Type:XTTypeOfUpCenter Color:[UIColor whiteColor] superView:self.view];
    view1.dataArray = @[@"出租",@"买卖",@"经纪人"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor blackColor];
    view1.delegate = self;
    [view1 popView];
}

- (IBAction)select:(id)sender {
    [self setupPopView];
    
}

- (void)searchClick{
    NSString *keyword = self.mysearchBar.text;
    //搜索地区
    if ([_searchTypeString isEqualToString:@"出租"]||[_searchTypeString isEqualToString:@"买卖"]) {
        
        NSDictionary *param =@{@"address":keyword};

        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:searchAreaUrlStr parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //json转模型
            self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObject];
            
            if (_searchResultArr.count == 0) {
                NSLog(@"搜索没有结果");
            }else{
                NSLog(@"找到结果，在载入数据");
            }
            [self.tableView reloadData];
            [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败 %@",error);
        }];


    }else{
    //搜索经纪人
        NSDictionary *param =@{@"arg":keyword};
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        [session GET:searchAgentUrlStr parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //json转模型
            self.searchResultArr = [EHAgentInfo mj_objectArrayWithKeyValuesArray:responseObject];
            
            if (_searchResultArr.count == 0) {
                NSLog(@"搜索没有结果");
            }else{
                NSLog(@"找到结果，在载入数据");
            }
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];


    }
}

@end
