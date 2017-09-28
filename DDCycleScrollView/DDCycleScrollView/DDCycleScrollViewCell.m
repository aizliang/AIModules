//
//  DDCycleScrollViewCell.m
//  DDCycleScrollView
//
//  Created by ai on 2017/7/4.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DDCycleScrollViewCell.h"
#import "UIImageView+WebCache.h"

@interface DDCycleScrollViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end


@implementation DDCycleScrollViewCell
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imageView];
    }
    
    return _imageView;
}


- (void)setImagePath:(NSString *)imagePath {
    if (_imagePath == imagePath) return;
    _imagePath = imagePath;
    if ([_imagePath hasPrefix:@"http"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imagePath]];
    } else {
        self.imageView.image = [UIImage imageWithContentsOfFile:_imagePath];
    }
    
}
@end
