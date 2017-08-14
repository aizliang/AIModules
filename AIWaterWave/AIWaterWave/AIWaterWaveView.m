//
//  AIWaterWaveView.m
//  AIWaterWave
//
//  Created by ai on 16/7/22.
//  Copyright © 2016年 ai. All rights reserved.
//

#import "AIWaterWaveView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation AIWaterWaveView {
    //变量放这里面无法被子类继承
    CADisplayLink *displayLink;
    CAShapeLayer *waveShapLayer;
    UIBezierPath *wavePath;
    CGFloat offsetX;
    CGFloat waveHeight;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        offsetX = 0;
        waveHeight = frame.size.height / 2;
    }
    return self;
}

- (void)wave {
    wavePath = [UIBezierPath bezierPath];
    waveShapLayer = [CAShapeLayer layer];
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    waveShapLayer = [CAShapeLayer layer];
    waveShapLayer.fillColor = [UIColor orangeColor].CGColor;
    [self.layer addSublayer:waveShapLayer];
}

- (void)getCurrentWave {
    offsetX = self.speed + offsetX;
    wavePath = [self getCurrentWavePath];
    waveShapLayer.path = wavePath.CGPath;
}

- (UIBezierPath *)getCurrentWavePath {
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, waveHeight);
    CGFloat y = 0;
    for (float x = 0.00; x < kWidth; x++) {
        y = self.amplitude * sinf((x * 2 * M_PI / kWidth) - offsetX * 180 / M_PI) + waveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, kWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    p.CGPath = path;
    CGPathRelease(path);
    return p;
}
     
- (void)stop {
    [displayLink invalidate];
    displayLink = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
