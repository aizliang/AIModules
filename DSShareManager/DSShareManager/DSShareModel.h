//
//  DSShareModel.h
//  DSShareManager
//
//  Created by ai on 2017/9/26.
//  Copyright © 2017年 ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSShareModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *linkUrl;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content imageData:(NSData *)imageData linkUrl:(NSString *)linkUrl;
@end
