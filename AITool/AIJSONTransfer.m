//
//  WWJSONTransfer.m
//  湾湾钱包
//
//  Created by ai on 2019/10/25.
//  Copyright © 2019 wind. All rights reserved.
//

#import "AIJSONTransfer.h"

@implementation AIJSONTransfer
+ (NSString *)changeDictionaryToJsonString:(NSDictionary *)dic {
    if (!dic) {
        return nil;
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSDictionary *)changeJsonStringToDictionary:(NSString *)jsonString {
    if (!jsonString) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        return nil;
    }
    
    return dic;
}
@end
