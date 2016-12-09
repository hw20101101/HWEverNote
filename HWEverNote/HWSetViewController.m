//
//  HWSetViewController.m
//  HWEverNote
//
//  Created by hw on 2016/12/8.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import "HWSetViewController.h"

@interface HWSetViewController ()

@end

@implementation HWSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self initNavigationItems];
}

- (void)initNavigationItems
{
    //left item
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction)];
    self.navigationItem.leftBarButtonItem = closeItem;
    
    //right item
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"退出登录" style:UIBarButtonItemStylePlain target:self action:@selector(logoutItemAction)];
    self.navigationItem.rightBarButtonItem = logoutItem;
    
    
}

- (void)closeItemAction
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{ }];
}

- (void)logoutItemAction
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
