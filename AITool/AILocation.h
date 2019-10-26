//
//  WWLocation.h
//  湾湾钱包
//
//  Created by ai on 2019/10/23.
//  Copyright © 2019 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WWGetLocationCompletionHandle)(BOOL success, NSDictionary *result);

@interface AILocation : NSObject
+ (id)shareInstance;
- (void)beginGetLocationWithCompletionHandle:(WWGetLocationCompletionHandle)completionHandle;
@end

NS_ASSUME_NONNULL_END
