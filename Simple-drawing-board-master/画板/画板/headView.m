//
//  headView.m
//  画板
//
//  Created by ai on 15/8/6.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import "headView.h"

@implementation headView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self setHeadView];
    }
    return self;
}

- (void)setHeadView{
    NSArray *names = @[@"颜色",@"线宽",@"橡皮",@"撤销",@"清屏"];
    CGFloat width = self.bounds.size.width/5;
    CGFloat height = self.bounds.size.height/5;
    for (int i = 0;i<5;i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(width*i, 10, width, height)];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 0:
            _block1();
            break;
        case 1:
            _block2();
            break;
        case 2:
            _block3();
            break;
        case 3:
            _block4();
            break;
        case 4:
            _block5();
            break;
            
        default:
            break;
    }}
@end
