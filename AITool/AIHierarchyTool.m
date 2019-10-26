//
//  AIHierarchyTool.m
//  湾湾钱包
//
//  Created by ai on 2019/10/26.
//  Copyright © 2019 wind. All rights reserved.
//

#import "AIHierarchyTool.h"

@implementation AIHierarchyTool

+ (UIViewController *)getTopViewController {
    UIViewController *resultVC = [self currentTopViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self currentTopViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)currentTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self currentTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self currentTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
