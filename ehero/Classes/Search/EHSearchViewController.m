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


@interface EHSearchViewController ()<selectIndexPathDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *selectionBtn;
- (IBAction)select:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mysearchBar;
@property (nonatomic,copy) NSString *searchTypeString;
@end

@implementation EHSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];


    //添加手势相应，输textfield时，点击其他区域，键盘消失
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EHSearchResultCell *cell = [EHSearchResultCell searchResultCellWithTableView:tableView];

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
    
    NSLog(@"开始搜索");
    
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

    
}

@end
