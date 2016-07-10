//
//  EHHomeViewController.m
//  ehero
//
//  Created by Mac on 16/7/7.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHHomeViewController.h"
#import <SDCycleScrollView.h>
#import "buttonCell.h"
#import "XTPopView.h"
#import "EHGuideViewController.h"
@interface EHHomeViewController ()<selectIndexPathDelegate,buttonCellDelegate>
{
    /** 图片数组*/
    NSMutableArray *sourceArr;
}


- (IBAction)siteBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *siteBtn;


@end

@implementation EHHomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    sourceArr = [NSMutableArray arrayWithObjects:@"img_00",@"img_01",@"img_02",@"img_03",@"img_04", nil];
    
    [self setupHeaderView];
    
    //跳转到下一界面的返回按钮样式
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 2) {
        return 5;
    }else{
        return 1;
    }

}

#pragma mark - section高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 5;
    }else{
        return 0.1;
    }

}

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 65;
    }else{
        return 30;
    }
}

#pragma mark - cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"reuseCell";
    //第一行 4个按钮
    if (indexPath.section == 0) {
        buttonCell *cell = [buttonCell buttonCellWithTableView:tableView];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setClickEvent];
        
 
        return cell;
    //第二行 点评经纪人
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"点评经纪人";
        return cell;
    //第三行 每日一房
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        }
        cell.textLabel.text = @"每日一房";
        return cell;
    }

}

#pragma mark - section标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return @"每日一房";
    }else{
        return @"";
    }
}

- (void)setupHeaderView{

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 10, 150) imageNamesGroup:sourceArr];
    self.tableView.tableHeaderView = cycleScrollView;
}


- (IBAction)siteBtnClick:(id)sender {
    [self setupPopView];
    
}
#pragma mark - 设置左上角地点
- (void)setupPopView{
    CGPoint point = CGPointMake(_siteBtn.center.x,_siteBtn.center.y + 45);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:80 Height:40 * 3 Type:XTTypeOfUpCenter Color:[UIColor whiteColor] superView:self.view];
    view1.dataArray = @[@"上海",@"广州", @"深圳"];
    view1.images = @[@"bookShelfPopMenuedit",@"bookShelfPopMenulist", @"bookShelfPopMenuImport"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor blackColor];
    view1.delegate = self;
    [view1 popView];
}
#pragma mark - 实现代理方法，左上角弹窗点击事件
- (void)selectIndexPathRow:(NSInteger)index{
    switch (index) {
        case 0:
        {
           self.siteBtn.titleLabel.text = @"上海";
        }
            break;
        case 1:
        {
            self.siteBtn.titleLabel.text = @"广州";
        }
            break;
        case 2:
        {
           self.siteBtn.titleLabel.text = @"深圳";
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 实现自定义cell里按钮点击的代理方法
- (void)firstBtnClick:(UITableViewCell *)cell{
    
    EHGuideViewController *guideViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"EHGuideViewController"];
    
    [self.navigationController pushViewController:guideViewController animated:YES];
 
    
    NSLog(@"first");
}

- (void)secondBtnClick:(UITableViewCell *)cell{
    NSLog(@"second");
}

- (void)thirdBtnClick:(UITableViewCell *)cell{
    NSLog(@"thrid");
}

- (void)fourthBtnClick:(UITableViewCell *)cell{
    NSLog(@"fourth");
}


@end
