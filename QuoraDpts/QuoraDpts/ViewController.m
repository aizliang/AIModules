//
//  ViewController.m
//  QuoraDpts
//
//  Created by ai on 2017/7/19.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *repeatView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAReplicatorLayer *repeatLayer = [CAReplicatorLayer layer];
    repeatLayer.frame = _repeatView.bounds;
    repeatLayer.instanceCount = 3;
    repeatLayer.instanceDelay = 0.2;
    [_repeatView.layer addSublayer:repeatLayer];
    
    CALayer *dotLayer = [CALayer layer];
    dotLayer.contents = (__bridge id)[UIImage imageNamed:@"dot"].CGImage;
    dotLayer.frame = CGRectMake(27, 0, 27, 27);
    [repeatLayer addSublayer:dotLayer];
    
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 60, 0, 0);
    repeatLayer.instanceTransform = transform;
    

    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.toValue = @(0.2);
    animation.duration = 0.5;
    animation.repeatCount = HUGE;
    animation.autoreverses = YES;
    [dotLayer addAnimation:animation forKey:@"可大可小"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
