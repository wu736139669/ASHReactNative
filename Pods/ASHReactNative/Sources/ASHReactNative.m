//
//  ASHReactNative.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHReactNative.h"
#import "ASHRNBundleManagerImpl.h"
#import "ASHRNViewFactoryImpl.h"
#import "ASHRNBridgeManagerImpl.h"
#import "NSString+Util.h"
@implementation ASHReactNative

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bundleManager = [ASHRNBundleManagerImpl  new];
        _viewFactory = [ASHRNViewFactoryImpl new];
        _rnbridgeFactory = [ASHRNBridgeManagerImpl new];
        
    }
    return self;
}

- (void)pushRNViewControllerWithURL:(NSString *)URL
{
    NSDictionary* dic = [URL ash_queryDictionary];
    [self pushRNViewControllerWithURL:URL modelName:dic[@"model"]];
}
- (void)pushRNViewControllerWithURL:(NSString *)URL modelName:(NSString *)model
{
    UIViewController *rnVC = nil;
    rnVC = [[ASHReactNative shareInstance].viewFactory rnViewControllerWithBundleURL:URL modelName:model];
    [[self getUsingViewController].navigationController pushViewController:rnVC animated:YES];
}
- (void)pushRNViewControllerWithBundleName:(NSString *)bundleName modelName:(NSString *)model
{
    UIViewController *rnVC = nil;
    rnVC = [[ASHReactNative shareInstance].viewFactory rnViewControllerWithBundleName:bundleName modelName:model];
    [[self getUsingViewController].navigationController pushViewController:rnVC animated:YES];
}
- (UIViewController*)getUsingViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([appRootVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController*)appRootVC visibleViewController];
    }
    if ([appRootVC isKindOfClass:[UIViewController class]]) {
        return appRootVC;
    }

    return nil;
}
@end
