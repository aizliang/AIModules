//
//  WWJSONTransfer.h
//  湾湾钱包
//
//  Created by ai on 2019/10/25.
//  Copyright © 2019 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIJSONTransfer : NSObject
+ (NSString *)changeDictionaryToJsonString:(NSDictionary *)dic;
+ (NSDictionary *)changeJsonStringToDictionary:(NSString *)jsonString;
@end

