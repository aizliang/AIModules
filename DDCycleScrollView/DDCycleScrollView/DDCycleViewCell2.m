//
//  DDCycleViewCell2.m
//  DDCycleScrollView
//
//  Created by ai on 2017/7/6.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DDCycleViewCell2.h"

@implementation DDCycleViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setImageUrl:(NSString *)imageUrl {
    if ([_imageUrl isEqualToString:imageUrl]) return;
    
    _imageUrl = imageUrl;
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_imageUrl]]];
    self.contentView.layer.contents = (__bridge id)image.CGImage;
}
@end
