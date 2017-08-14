//
//  AIFrontVC.m
//  侧滑抽屉
//
//  Created by ai on 17/2/21.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "AIFrontVC.h"
#import "SWRevealViewController.h"

@interface AIFrontVC ()
@property (nonatomic, strong) SWRevealViewController *revealVC;
@end

@implementation AIFrontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self addLeftItem];

    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLeftItem {
    self.navigationController.navigationBarHidden = YES;
    
    self.revealVC = [self revealViewController];
    [_revealVC tapGestureRecognizer];
    [_revealVC panGestureRecognizer];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [button setTitle:@"left" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:_revealVC action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushNewVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)pushNewVC {
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
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
