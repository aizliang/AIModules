//
//  ViewController.m
//  AIWaterWave
//
//  Created by ai on 16/7/22.
//  Copyright © 2016年 ai. All rights reserved.
//

#import "ViewController.h"
#import "AIWaterWaveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AIWaterWaveView *waterView = [[AIWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2)];
    [self.view addSubview:waterView];
    
    waterView.speed = 0.002;
    waterView.amplitude = 20;
    [waterView wave];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
