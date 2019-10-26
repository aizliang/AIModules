//
//  AIContact.h
//  湾湾钱包
//
//  Created by ai on 2019/10/26.
//  Copyright © 2019 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WWSelectLinkManCompletion)(NSDictionary *linkManInfo);

@interface AIContact : NSObject
+ (instancetype)shareInstance;
- (void)showContactWithCompletion:(WWSelectLinkManCompletion)completion;
@end

