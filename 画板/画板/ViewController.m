//
//  ViewController.m
//  画板
//
//  Created by ai on 15/8/5.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import "ViewController.h"
#import "colorPiker.h"
#import "touchView.h"
#import "headView.h"
#import "font.h"
@interface ViewController (){
    touchView *_touchView;
    colorPiker *color;
    font *fontView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [self setFont];
    [self setHeadView];
    [self setColorPiker];
    [self setTouchView];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)setColorPiker{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"colorPiker" owner:nil options:nil];
    color = [views lastObject];
    color.backgroundColor = [UIColor grayColor];
    color.frame = CGRectMake(0, 50, 375, 40);
    color.block = ^(UIColor *selectColor){
        _touchView.color = selectColor;
    };
    [self.view addSubview:color];
}

- (void)setFont{
    fontView = [[font alloc]initWithFrame:CGRectMake(0, 50, 375, 40)];
    fontView.hidden = YES;
    fontView.block = ^(NSInteger font){
        _touchView.width = font;
    };
    fontView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:fontView];
}

- (void)setHeadView{
    headView *head = [[headView alloc]initWithFrame:CGRectMake(0, 20, 375, 30)];
    head.block1 = ^{
        color.hidden =  NO;
        fontView.hidden = YES;
    };
    head.block2 = ^{
        color.hidden = YES;
        fontView.hidden = NO;
    };
    head.block3 = ^{
        _touchView.color = [UIColor whiteColor];
    };

    head.block4 = ^{
        [_touchView.paths removeLastObject];
        [_touchView setNeedsDisplay];
    };
    
    head.block5 = ^{
        [_touchView.paths removeAllObjects];
        [_touchView setNeedsDisplay];
            };
    [self.view addSubview:head];
}

- (void)setTouchView{
    _touchView = [[touchView alloc]initWithFrame:CGRectMake(0, 90, 375, self.view.bounds.size.height-150)];
    _touchView.color = [UIColor redColor];
    _touchView.width = 1;
    _touchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_touchView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
