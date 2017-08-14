//
//  ControllView.m
//  scrollerViewResponse
//
//  Created by ai on 15/12/17.
//  Copyright © 2015年 ai. All rights reserved.
//

#import "ControllView.h"
#import "ScrollVeiw.h"
#import "ColorView.h"
#import <UIKit/UIKit.h>

#define KWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

@interface ControllView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *zoomView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ControllView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configScrollView];
    }
    return self;
}

- (void)configScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.contentSize = CGSizeMake((KWidth - 40) * 5 + 60, KHeight - 60);
    self.scrollView.frame = CGRectMake(10, 40, KWidth - 30, KHeight - 60);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;  //使得scrollerView只能在一个方向上滑动
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滑动指示样式
    self.scrollView.decelerationRate = 100;  //减速速度
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    [self addSubVeiws];
}

-(void)addSubVeiws {
    for (int i = 0; i < 5; i++) {
        ColorView *view = [[ColorView alloc] init];
        UIColor *bgColor;
        if (i % 2 == 0) {
            bgColor = [UIColor orangeColor];
        } else {
            bgColor = [UIColor grayColor];
        }
        
        view.tag = i;
        view.backgroundColor = bgColor;
        int viewWidth = KWidth - 40;
        view.frame = CGRectMake(viewWidth * i + 10 * i + 10, 0, viewWidth, self.scrollView.frame.size.height);
        [self.scrollView addSubview:view];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return self.scrollView;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.zoomView;
}
@end
