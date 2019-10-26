//
//  WWLocation.m
//  湾湾钱包
//
//  Created by ai on 2019/10/23.
//  Copyright © 2019 wind. All rights reserved.
//

#import "AILocation.h"
#import <CoreLocation/CoreLocation.h>

@interface AILocation ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (nonatomic,strong) WWGetLocationCompletionHandle completionHandle;
@end

@implementation AILocation

+ (id)shareInstance {
    static dispatch_once_t onceToken;
    static AILocation *location;
    dispatch_once(&onceToken, ^{
        location = [AILocation new];
        location.manager = [[CLLocationManager alloc] init];
        location.manager.delegate = location;
        [location.manager requestWhenInUseAuthorization];
    });
    
    return location;
}

- (void)beginGetLocationWithCompletionHandle:(WWGetLocationCompletionHandle)completionHandle {
    self.completionHandle = completionHandle;
    if ([CLLocationManager locationServicesEnabled]) {
        [self.manager requestLocation];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations  {
    NSMutableDictionary *resultDic = [@{@"longitude": @"",
                                        @"latitude": @""
                                        } mutableCopy];
    
    if (locations.count == 0) {
        _completionHandle(NO, resultDic);
        return;
    }
    
    CLLocation *location = locations.firstObject;
    resultDic[@"latitude"] = @(location.coordinate.latitude);
    resultDic[@"longitude"] = @(location.coordinate.longitude);
    _completionHandle(YES, resultDic);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:  //用户还未决定授权
        {
            break;
        }
        case kCLAuthorizationStatusRestricted:  //访问受限
        {
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            if ([CLLocationManager locationServicesEnabled]) {
                //定位服务开启，被拒绝
            } else {
                //定位服务关闭，不可用
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:  //获得前后台授权
        {
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:  //获得前台授权
        {
        
            break;
        }
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _completionHandle(NO, @{@"longitude": @"",
                            @"latitude": @""
                            });
}

@end
