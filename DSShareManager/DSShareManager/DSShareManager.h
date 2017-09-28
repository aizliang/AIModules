//
//  DSShareManager.h
//  DSShareManager
//
//  Created by ai on 2017/9/26.
//  Copyright © 2017年 ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSShareModel.h"

//MARK: 分享类型
typedef enum : NSUInteger {
    ShareToWXSession,
    ShareToWXCicle,
    ShareToQQZone,
    ShareToQQSession,
    ShareToWB
} DSShareType;


@interface DSShareManager : NSObject

+ (instancetype)shareManager;
- (void)shareWithModel:(DSShareModel *)model shareType:(DSShareType)type;

@end

