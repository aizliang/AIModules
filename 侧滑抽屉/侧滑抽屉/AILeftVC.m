//
//  AILeftVC.m
//  侧滑抽屉
//
//  Created by ai on 17/2/21.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "AILeftVC.h"

@interface AILeftVC ()

@end

@implementation AILeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self addAction];
    // Do any additional setup after loading the view.
}

- (void)addAction {
    UIButton *pushButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushNewVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)pushNewVC {
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
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
