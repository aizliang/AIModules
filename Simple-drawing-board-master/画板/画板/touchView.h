//
//  touchView.h
//  画板
//
//  Created by ai on 15/8/5.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "line.h"

@interface touchView : UIView{
    CGMutablePathRef path; 
}
@property (nonatomic,strong) NSMutableArray *paths;
@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) CGFloat width;
@end
