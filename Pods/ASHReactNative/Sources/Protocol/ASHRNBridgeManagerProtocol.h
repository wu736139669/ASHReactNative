//
//  ASHRNBridgeManagerProtocol.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RCTBridge;
@protocol ASHRNBridgeManagerProtocol <NSObject>


/**
 获取RCTBridge
 @param bundleUrl 包地址
 @param initialProperties 初始化参数
 @return RCTBridge
 */
- (RCTBridge* _Nullable)bridgeWithBundleUrl:(NSURL* _Nonnull)bundleUrl launchOptions:(NSDictionary* _Nullable)initialProperties;
@end

