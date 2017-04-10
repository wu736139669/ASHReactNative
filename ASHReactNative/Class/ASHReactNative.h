//
//  ASHReactNative.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASHRNBridgeManagerProtocol.h"
#import "ASHRNViewFactoryProtocol.h"
#import "ASHRNBundleManagerProtocol.h"
@interface ASHReactNative : NSObject

/// js bundle 加载管理器
@property (nonatomic, strong, readonly) id<ASHRNBundleManagerProtocol> bundleManager;

/// rn view 生成工厂
@property (nonatomic, strong, readonly) id<ASHRNViewFactoryProtocol> viewFactory;

/// rn bridge 生成工厂
@property (nonatomic, strong, readonly) id<ASHRNBridgeManagerProtocol> rnbridgeFactory;
+ (instancetype)shareInstance;


/**
 url加载页面，model:url上读取，如果没有默认加载model:index页面
 
 @param URL 包地址
 */

- (void)pushRNViewControllerWithURL:(NSString *)URL;
/**
 url加载页面，默认加载model:index页面
 
 @param URL 包地址
 */
- (void)pushRNViewControllerWithURL:(NSString *)URL modelName:(NSString*)model;


/**
 加载本地包地址
 
 @param bundleName 包名称
 @param model 页面名称
 */
- (void)pushRNViewControllerWithBundleName:(NSString *)bundleName modelName:(NSString *)model;
@end
