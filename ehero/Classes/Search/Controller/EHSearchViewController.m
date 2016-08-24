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
#import "EHNetBusinessManager.h"
#import "MBProgressHUD+YT.h"
#import "EHSearchBar.h"
#import "EHSearchTableViewModel.h"

#define searchbar_width _mysearchBar.frame.size.width
#define searchbar_height _mysearchBar.frame.size.height

@interface EHSearchViewController ()<UITextFieldDelegate,EHNetBusinessManagerDelegate,EHSearchResultCellDelegate>

@property (weak, nonatomic) IBOutlet UITextField *mysearchBar;
//@property (nonatomic,strong) NSMutableArray *searchResultArr;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) EHSearchTableViewModel *tableViewModel;

@end

@implementation EHSearchViewController

//- (NSMutableArray *)searchResultArr{
//    if (_searchResultArr == nil) {
//        _searchResultArr = [NSMutableArray array];
//    }
//    return _searchResultArr;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = RGB(241, 243, 245);

    [self setupSearchBar];
    [self addGesture];
    [YTHttpTool netCheck];
    [self setNavBar];
    
    self.navigationItem.backBarButtonItem = [EHNavBackItem setBackTitle:@""];
    
    _tableViewModel = [[EHSearchTableViewModel alloc]init];
    
    self.tableView.dataSource = _tableViewModel;
    self.tableView.delegate = _tableViewModel;
    
    @weakify(self);
    [RACObserve(_tableViewModel, searchResultArr) subscribeNext:^(id x) {
        
        @strongify(self);
        [self.tableView reloadData];
        [LBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
    }];
    

}

- (void)setNavBar{
    //自定义返回按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 14, 23.6);
    [leftBtn setImage:[UIImage imageNamed:@"Back Arrow"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(NavPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *negativeSpacer1 = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace target : nil action : nil ];
    
    UIBarButtonItem *negativeSpacer2 = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace target : nil action : nil ];
    
    negativeSpacer2.width = 15;
    negativeSpacer1.width = - 10 ;//这个数值可以根据情况自由变化
    self.navigationItem.leftBarButtonItems = @[negativeSpacer1,backItem,negativeSpacer2];
}

- (void)NavPop{
    [[self navigationController]popViewControllerAnimated:YES];
}



#pragma mark - 选择cell
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    EHAgentInfoController *agentInfoVC = [[self storyboard]instantiateViewControllerWithIdentifier:@"AgentInfoController"];
//    EHAgentInfo *agentInfo = self.searchResultArr[indexPath.row];
//    [agentInfo getIdStringFromDictionary];
//    
//    agentInfoVC.agentInfo = agentInfo;
//    
//    [self.navigationController pushViewController:agentInfoVC animated:YES];
//}


#pragma mark - 编辑完成，点击搜索时调用代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //[self.searchResultArr removeAllObjects];
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
    [self.tableViewModel searchWithURLString:searchAreaUrlStr Param:param];


}


- (void)callBtnClick:(UITableViewCell *)cell{
    NSLog(@"在控制器里点击");
    
}


@end
