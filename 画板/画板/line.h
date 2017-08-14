//
//  line.h
//  画板
//
//  Created by ai on 15/8/6.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface line : UIView
@property (nonatomic,assign) CGMutablePathRef path;
@property (nonatomic,strong) UIColor *lineColor;
@property (nonatomic,assign) CGFloat width;
@end
