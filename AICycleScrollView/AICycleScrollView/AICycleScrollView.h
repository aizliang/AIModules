//
//  AICycleScrollView.h
//  AICycleScrollView
//
//  Created by ai on 2017/8/16.
//  Copyright © 2017年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickCycleView)(NSInteger);

@interface AICycleScrollView : UIView

/**
 数据源
 */
@property (nonatomic, strong) NSArray *records;

/**
 两个 item 之间的间距
 */
@property (nonatomic, assign) CGFloat itemSpace;


/**
 图片高度缩放大小
 */
@property (nonatomic, assign) CGFloat itemScaleHeight;


/**
 ScrollView 的大小，自动居中
 */
@property (nonatomic, assign) CGSize scrollViewSize;


/**
 是否循环滚动，默认开启
 */
@property (nonatomic, assign) BOOL autoScroll;


/**
 滚动时间间隔
 */
@property (nonatomic, assign) CGFloat timeInterval;


/**
 点击事件回调
 */
@property (nonatomic, copy) ClickCycleView didClickCycleView;
@end


@interface AIImageView : UIView
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, strong) UIImageView *imageView;
@end
