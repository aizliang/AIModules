//
//  touchView.m
//  画板
//
//  Created by ai on 15/8/5.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import "touchView.h"
@implementation touchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _paths = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
   CGContextRef context =  UIGraphicsGetCurrentContext();
    //绘制以前存放在数组中的路径
    for (line *pastLine in _paths) {
        [pastLine.lineColor setStroke];
        CGContextSetLineWidth(context, pastLine.width);
        //先添加path，再绘制path
        CGContextAddPath(context, pastLine.path);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    //绘制本次路径
    if (path != nil) {
        [self.color setStroke];
        CGContextSetLineWidth(context, self.width);
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathStroke);
    }
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //创建一条路径
    path = CGPathCreateMutable();
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    CGPathMoveToPoint(path, NULL, p.x, p.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    //把移动的点加到路径里面并绘制
    CGPathAddLineToPoint(path, NULL, p.x, p.y);
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //将这条路径加到数组中
    line *newLine = [[line alloc]init];
    newLine.width = _width;
    newLine.path = path;
    newLine.lineColor = _color;
    [_paths addObject:newLine];
    CGPathRelease(path);
    path = nil;
}
@end
