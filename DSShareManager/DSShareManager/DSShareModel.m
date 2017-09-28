//
//  DSShareModel.m
//  DSShareManager
//
//  Created by ai on 2017/9/26.
//  Copyright © 2017年 ai. All rights reserved.
//

#import "DSShareModel.h"

@implementation DSShareModel

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content imageData:(NSData *)imageData linkUrl:(NSString *)linkUrl {
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.imageData = imageData;
        self.linkUrl = linkUrl;
    }
    
    return self;
}

@end
