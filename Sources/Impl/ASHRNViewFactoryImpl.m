//
//  ASHRNViewFactoryImpl.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHRNViewFactoryImpl.h"
#import "ASHRNViewController.h"
@implementation ASHRNViewFactoryImpl
- (UIViewController*)rnViewControllerWithBundleURL:(NSString *)bundleURL modelName:(NSString *)modelName
{
    return [[ASHRNViewController alloc] initWithBundleURL:bundleURL modelName:modelName];
}
- (UIViewController*)rnViewControllerWithBundleName:(NSString *)bundleName modelName:(NSString *)modelName
{
    return [[ASHRNViewController alloc] initWithBundleName:bundleName modelName:modelName];
}
@end
