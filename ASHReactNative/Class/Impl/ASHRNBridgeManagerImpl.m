//
//  ASHRNBridgeManagerImpl.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHRNBridgeManagerImpl.h"
#import <RCTBridge.h>
#import <RCTConvert.h>
@interface ASHRNBridgeManagerImpl()
@property(nonatomic, strong)NSMutableArray* bridgeArr;
@end

@implementation ASHRNBridgeManagerImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bridgeArr = [NSMutableArray array];
    }
    return self;
}

- (RCTBridge*)bridgeWithBundleUrl:(NSURL *)bundleUrl launchOptions:(NSDictionary *)initialProperties
{
    if (!bundleUrl) {
        return nil;
    }
    for (RCTBridge* obj in self.bridgeArr) {
        if ([[obj.bundleURL absoluteString] isEqualToString:[RCTConvert NSURL:bundleUrl.absoluteString].absoluteString]) {
            return obj;
        }
    }
    RCTBridge* bridge = [[RCTBridge alloc] initWithBundleURL:bundleUrl
                                              moduleProvider:nil
                                               launchOptions:initialProperties];
    if (bridge) {
        [self.bridgeArr addObject:bridge];
    }
    return bridge;
}
@end
