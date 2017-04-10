//
//  ASHRNViewFactoryProtocol.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol ASHRNViewFactoryProtocol <NSObject>

/**
 加载网络地址的包
 
 @param bundleURL 包地址
 @param modelName 页面名称
 @return 返回页面VC
 */
- (UIViewController*)rnViewControllerWithBundleURL:(NSString *)bundleURL modelName:(NSString *)modelName;


/**
 加载本地包
 
 @param bundleName 包名称
 @param modelName 页面名称
 @return 返回页面VC
 */
- (UIViewController *)rnViewControllerWithBundleName:(NSString *)bundleName modelName:(nullable NSString *)modelName;
@end
NS_ASSUME_NONNULL_END
