//
//  AIWaterWaveView.h
//  AIWaterWave
//
//  Created by ai on 16/7/22.
//  Copyright © 2016年 ai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AIWaterWaveView : UIView
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) CGFloat amplitude;

- (void)wave;
- (void)stop;
@end
