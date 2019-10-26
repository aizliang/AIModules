//
//  AIDeviceTool.h
//  湾湾钱包
//
//  Created by ai on 2019/10/26.
//  Copyright © 2019 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIDeviceTool : NSObject

/// 厂商
+ (NSString *)getDeviceBrand;

/// 型号
+ (NSString *)getDeviceName;

/// app 版本
+ (NSString *)getAPPVersion;

/// build 号
+ (NSString *)getAPPBuildVersion;

/// 电池电量
+ (float)getDeviceBatteryLevel;

/// 系统
+ (NSString *)getCurrentSysName;

/// 系统版本
+ (NSString *)getSysVersion;

/// 设备唯一标识
+ (NSString *)getIdfa;

@end

