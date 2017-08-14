//
//  line.m
//  画板
//
//  Created by ai on 15/8/6.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import "line.h"

@implementation line

- (void)setPath:(CGMutablePathRef)path{
    if (_path != path) {
        //这里retain一次之后path之后释放就不会没掉了，可以找到他
        _path = CGPathRetain(path);
    }
}

@end
