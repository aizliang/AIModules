//
//  DSLinkageLabel.m
//  DSLinkageVC
//
//  Created by ai on 2017/8/30.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DSLinkageLabel.h"

@implementation DSLinkageLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [_fillColor set];
    rect.size.width = rect.size.width * _progress;
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
    }
    
    return self;
}


- (void)setProgress:(float)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
