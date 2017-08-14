//
//  headView.h
//  画板
//
//  Created by ai on 15/8/6.
//  Copyright (c) 2015年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^buttonType)(void);
@interface headView : UIView
@property (nonatomic,strong) buttonType block1;
@property (nonatomic,strong) buttonType block2;
@property (nonatomic,strong) buttonType block3;
@property (nonatomic,strong) buttonType block4;
@property (nonatomic,strong) buttonType block5;

@end
