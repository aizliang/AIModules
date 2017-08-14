//
//  colorPiker.h
//  画板
//
//  Created by ai on 15/8/5.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^type)(UIColor *);
@interface colorPiker : UIView
@property (nonatomic,strong) type block;
@property (strong, nonatomic) IBOutlet UIButton *color1;

@property (weak, nonatomic) IBOutlet UIButton *color2;
@property (weak, nonatomic) IBOutlet UIButton *color3;
@property (weak, nonatomic) IBOutlet UIButton *color4;
@property (weak, nonatomic) IBOutlet UIButton *color5;
@property (weak, nonatomic) IBOutlet UIButton *color6;
@property (weak, nonatomic) IBOutlet UIButton *color7;
@property (nonatomic,strong) UIColor *color;
@end
