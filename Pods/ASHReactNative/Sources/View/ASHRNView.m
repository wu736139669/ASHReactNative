//
//  ASHRNView.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHRNView.h"
#import "NSString+Util.h"
#import "ASHReactNative.h"
#import <MBProgressHUD.h>
#import <RCTBridge.h>
#import <RCTRootView.h>
@interface ASHRNView()
@property (nonatomic, copy) NSString *bundlePath;
@property (nonatomic, copy) NSString *indexPath;
@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, strong)RCTRootView* rootView;

@property (nonatomic, assign)CGFloat realWidth;
@property (nonatomic, assign)CGFloat realHeigh;
@end
@implementation ASHRNView
@synthesize bundleURL = _bundleURL;
@synthesize indexPath = _indexPath;
@synthesize modelName = _modelName;
RCT_EXTERN void RCTRegisterModule(Class);

+ (NSString *)moduleName {
    return @"ASHRNView";
}

- (void)loadBundle:(NSString *)bundleUrl
{
    NSDictionary* dic = [bundleUrl ash_queryDictionary];
    NSString* model = dic[@"model"];
    if (!model.length) {
        model = @"index";
    }
    [self loadBundle:bundleUrl withModelName:model];
}
- (void)loadBundle:(NSString *)bundleUrl withModelName:(NSString *)modelName
{
    if (![_bundleURL isEqualToString:bundleUrl] || ![_modelName isEqualToString:modelName]) {
        
        NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:[bundleUrl ash_queryDictionary]];
        if([dic objectForKey:@"width"]){
            self.realWidth = [[dic objectForKey:@"width"] floatValue];
        }
        if([dic objectForKey:@"heigh"]){
            self.realHeigh = [[dic objectForKey:@"heigh"] floatValue];
        }
        if (self.initialProperties) {
            [dic addEntriesFromDictionary:self.initialProperties];
        }
        self.initialProperties = dic;
        if (!modelName.length) {
            modelName = dic[@"model"];
            if (!modelName.length) {
                modelName = @"index";
            }
        }
        _bundleURL = bundleUrl;
        _modelName = modelName;
        [self refreshRNView];
    }
}

- (void)loadBundleName:(NSString *)bundleName
{
    [self loadBundleName:bundleName modelName:@"index"];
}
- (void)loadBundleName:(NSString *)bundleName modelName:(NSString *)modelName
{
    if (![self.indexPath isEqualToString:bundleName] || ![_modelName isEqualToString:modelName]) {
        self.indexPath = bundleName;
        self.modelName = modelName;
        [self refreshRNView];
    }
}
- (void)refreshRNView
{
    [self loadRNView];
}
- (void)loadRNView
{
    if([self.viewDelegate respondsToSelector:@selector(rnViewDidCreated:)]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewDelegate rnViewDidCreated:self];
        });
        
    }
    if (self.bundleURL) {
        __weak typeof(self) wself = self;
        NSURL *URL = [NSURL URLWithString:self.bundleURL];
        [[ASHReactNative shareInstance].bundleManager downloadWithBundleURL:URL completedBlock:^(NSString *indexPath, NSString *bundlePath, NSError *error) {
            __strong typeof(self) sself = wself;
            if (error) {
                [self delegateError:error];
            } else {
                sself.bundlePath = bundlePath;
                sself.indexPath = indexPath;
                [sself loadRNWithIndexPath:self.indexPath];
            }
        }];
    } else {
        [self loadRNWithIndexPath:self.indexPath];
    }
}

- (void)loadRNWithIndexPath:(NSString*)indexPath
{
    
    if (!indexPath.length) {
        [self delegateError:[NSError errorWithDomain:@"nil path" code:-9999 userInfo:@{@"msg":@"nil path"}]];
        return;
    }
    
    NSURL* bundleUrl = [NSURL URLWithString:indexPath];
    RCTBridge *bridge = [[ASHReactNative shareInstance].rnbridgeFactory bridgeWithBundleUrl:bundleUrl launchOptions:nil];
    
    if(!bridge.isValid){
        [self delegateError:[NSError errorWithDomain:@"bridge invalid" code:-9999 userInfo:@{@"msg":@"bridge invalid"}]];
        return;
    }
    if (!self.modelName) {
        self.modelName = @"index";
    }
    RCTRootView* rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:self.modelName initialProperties:self.initialProperties];
    rootView.frame = self.bounds;
    self.rootView = rootView;
    [self addSubview:rootView];
    if ([self.viewDelegate respondsToSelector:@selector(rnViewDidRenderFinish:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewDelegate rnViewDidRenderFinish:self];
        });
        
    }
}

- (void)delegateError:(NSError*)error
{
    if ([self.viewDelegate respondsToSelector:@selector(rnView:didFailed:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewDelegate rnView:self didFailed:error];
        });
        
    }
}
#pragma mark - 刷新RN页面
- (void)reloadPage {
    [self reloadPageWithProperties:nil];
}
- (void)reloadPageWithProperties:(NSDictionary *)params {
    self.initialProperties = params;
    [self refreshRNView];
}
@end
