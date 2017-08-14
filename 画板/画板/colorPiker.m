//
//  colorPiker.m
//  画板
//
//  Created by ai on 15/8/5.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import "colorPiker.h"
@implementation colorPiker

- (void)awakeFromNib{
    [super awakeFromNib];
    [self selectColor];
}
- (void)selectColor{
    NSArray *colors = @[_color1,_color2,_color3,_color4,_color5,_color6,_color7];
    for (UIButton *myColor in colors) {
        [myColor addTarget:self action:@selector(selectColors:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)selectColors:(UIButton *)button{
    _color = button.backgroundColor;
    _block(_color);
}
@end
