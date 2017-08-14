//
//  ViewController.m
//  scrollerViewResponse
//
//  Created by ai on 15/12/17.
//  Copyright © 2015年 ai. All rights reserved.
//

#import "ViewController.h"
#import "ControllView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ControllView *controllView  = [[ControllView alloc] initWithFrame:self.view.frame];
    //controllView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:controllView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
