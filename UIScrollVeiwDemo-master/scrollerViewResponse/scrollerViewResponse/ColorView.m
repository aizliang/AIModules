//
//  colorView.m
//  scrollerViewResponse
//
//  Created by ai on 15/12/17.
//  Copyright © 2015年 ai. All rights reserved.
//

#import "ColorView.h"
#import <UIKit/UIKit.h>
@implementation ColorView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%li",self.tag);
}
@end
