//
//  DDCycleScrollView.h
//  DDCycleScrollView
//
//  Created by ai on 2017/7/4.
//  Copyright © 2017年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"

typedef void(^clickCycleViewBlock)(NSInteger index);
typedef void(^setCellDataBlock)(UICollectionViewCell *cell,NSInteger index);

@interface DDCycleScrollView : UIView

@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@property (nonatomic, assign) BOOL showPageControl;
@property (nonatomic, assign) BOOL autoScroll;
@property (nonatomic, assign) BOOL scrollEnabled;

@property (nonatomic, copy)  clickCycleViewBlock didClickCycleView;
@property (nonatomic, copy) setCellDataBlock setCellData;


/**
 默认4.0s
 */
@property (nonatomic, assign) NSTimeInterval timeInterval;


/**
 SMPageControl 支持自定义
 */
@property (nonatomic, strong) SMPageControl *pageControl;

/**
 轮播图个数
 */
@property (nonatomic, assign) NSInteger cellCount;


- (instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll cellCount:(NSInteger)cellCount cellFromClass:(NSString*)className;
- (instancetype)initWithFrame:(CGRect)frame autoScroll:(BOOL)autoScroll cellCount:(NSInteger)cellCount cellFromNib:(NSString*)nibName;

/**
 自定义UICollectionViewCell
 className和nibName两个参数必须传一个，若两个都不传使用默认的cell，若两个都传使用className
 调用该方法之后记得修改cell的数据源和点击事件
 
 @param className UICollectionViewCell 类名
 @param nibName UICollectionViewCell nib名
 */
- (void)setCycleViewReuseCellFromClass:(NSString *)className nibName:(NSString *)nibName;
@end
