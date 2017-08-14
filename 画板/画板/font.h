//
//  font.h
//  画板
//
//  Created by ai on 15/8/6.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^typwFont)(NSInteger);
@interface font : UIView
@property (nonatomic,strong) typwFont block;
@end
