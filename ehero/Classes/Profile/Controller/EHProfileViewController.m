//
//  EHProfileViewController.m
//  ehero
//
//  Created by Mac on 16/7/22.
//  Copyright © 2016年 ehero. All rights reserved.
//

#import "EHProfileViewController.h"

@interface EHProfileViewController ()
- (IBAction)skimedAgentsClick:(id)sender;
- (IBAction)skimedHouseClick:(id)sender;
- (IBAction)tipsClick:(id)sender;
- (IBAction)agentsClick:(id)sender;
- (IBAction)houseClick:(id)sender;
- (IBAction)contactClick:(id)sender;
- (IBAction)aboutClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tips;
@property (weak, nonatomic) IBOutlet UIButton *agents;
@property (weak, nonatomic) IBOutlet UIButton *house;
@property (weak, nonatomic) IBOutlet UIButton *contact;
@property (weak, nonatomic) IBOutlet UIButton *about;


@end

@implementation EHProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(241, 243, 245);

    [self setupButtonsTextAlignment];
    
}

- (void)setupButtonsTextAlignment{
    self.tips.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.tips.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.agents.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.agents.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.house.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.house.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.contact.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contact.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.about.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.about.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
}


- (IBAction)skimedAgentsClick:(id)sender {
}

- (IBAction)skimedHouseClick:(id)sender {
}

- (IBAction)tipsClick:(id)sender {
}

- (IBAction)agentsClick:(id)sender {
}

- (IBAction)houseClick:(id)sender {
}

- (IBAction)contactClick:(id)sender {
}

- (IBAction)aboutClick:(id)sender {
}
@end
