//
//  DSLinkageVC.h
//  DSLinkageVC
//
//  Created by ai on 2017/8/29.
//  Copyright © 2017年 ai. All rights reserved.
//

/**
    特别注意：当 VC 别添加到内部 Cell 上的时候，frame 会被改变
    建议一开始就讲 VC 的 frame 设置成 Cell 上的 frame 
    或者 VC 中的子视图使用相对布局
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TitleColorTransformStyle) {
    TitleColorTransformShiftNone = 0,
    TitleColorTransformShiftLocation,
    TitleColorTransformShiftColor
};

@interface DSLinkageVC : UIViewController


/**
 联动视图的frame
 */
@property (nonatomic, assign) CGRect contentViewFrame;

/**
 标题栏frame
 */
@property (nonatomic, assign) CGRect titleViewFrame;


/**
 当前选中的标题索引
 */
@property (nonatomic, assign) int index;


/**
 通过标题和控制器初始化，标题的个数与控制器的个数应该相同
 不相同则以个数少的为依据显示（不能为空）

 @param titles 标题数组
 @param vcs 控制器数组
 */
- (instancetype)initWithTitles:(NSArray *)titles vcs:(NSArray *)vcs;


/**
 设置或切换拖动的时候标题变化样式

 @param titleTransformStyle 标题颜色变幻样式
 @param titleScale 标题缩放的值
 */
- (void)setTilteTransformWithStyle:(TitleColorTransformStyle)titleTransformStyle titleScale:(float)titleScale;


/**
 设置标题栏样式

 @param backgroundColor 标题栏背景
 @param norColor 未选中标题颜色
 @param selColor 选中标题颜色
 @param titleFont 标题字体大小
 */
- (void)setTitleViewWithBackgroundColor:(UIColor *)backgroundColor norColor:(UIColor *)norColor selColor:(UIColor *)selColor titleFont:(UIFont *)titleFont;



/**
 更新数据源

 @param titles 标题数组
 @param vcs 控制器数组
 */
- (void)changeWithTitles:(NSArray *)titles vcs:(NSArray *)vcs;
@end
