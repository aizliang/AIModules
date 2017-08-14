//
//  ViewController.m
//  TwitterBird
//
//  Created by ai on 2017/6/26.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) CALayer  *bird;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.63 blue:0.94 alpha:1];

    self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitterScreen"]];
    self.bg.frame = self.view.bounds;
    [self.view addSubview:self.bg];
    
    self.bird = [CALayer layer];
    self.bird.contents = (__bridge id)[UIImage imageNamed:@"twitterBird"].CGImage;
    self.bird.frame = CGRectMake(0, 0, 100, 80);
    self.bird.position = self.view.center;
//    [self.view.layer addSublayer:self.bird];
    
    self.bg.layer.mask = self.bird;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [self animation];
}

- (void)animation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(25, 25)];
    animation.beginTime = CACurrentMediaTime() + 0.5;
    animation.duration = 0.8;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.bird addAnimation:animation forKey:@"let's fly"];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.bird = nil;
    self.bg.layer.mask = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
