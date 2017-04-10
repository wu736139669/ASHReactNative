//
//  ASHRNBundleManagerProtocol.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol ASHRNBundleManagerProtocol <NSObject>
- (BOOL)containBundleURL:(NSURL *)bundleURL;
- (void)downloadWithBundleURL:(NSURL *)bundleURL completedBlock:(nullable void(^)(NSString *indexPath, NSString *bundlePath,NSError * _Nullable error))completedBlock;
@end
NS_ASSUME_NONNULL_END
