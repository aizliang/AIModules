//
//  font.m
//  画板
//
//  Created by ai on 15/8/6.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import "font.h"

@implementation font
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFont];
    }
    return  self;
}

- (void)setFont{
    CGFloat width = self.bounds.size.width/7;
    CGFloat height = self.bounds.size.height;
    for (int i =0; i<7; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(width*i, 0, width, height)];
        NSString *title = [NSString stringWithFormat:@"%d点",(i+1)*2];
        button.tag = (i+1)*2;
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)button{
    _block(button.tag);
}
@end
