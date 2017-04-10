//
//  ASHRNView.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASHRNView, RCTRootView;
@protocol ASHRNViewDelegate <NSObject>
@optional
- (void)rnViewDidCreated:(ASHRNView *)rnView;

- (void)rnView:(ASHRNView *)rnView didFailed:(NSError *)error;

- (void)rnViewDidRenderFinish:(ASHRNView *)rnView;

@end
@interface ASHRNView : UIView

#pragma mark method
/**
 网络路径，默认加载 model: index.
 
 @param bundleUrl 包地址
 */
- (void)loadBundle:(NSString*)bundleUrl;

/**
 网络路径
 
 @param bundleUrl bundleUrl 包地址
 @param modelName 页面名称
 */
- (void)loadBundle:(NSString*)bundleUrl withModelName:(NSString*)modelName;



/**
 加载本地包
 
 @param bundleName 本地包名称
 */
- (void)loadBundleName:(NSString*)bundleName;


/**
 加载本地包
 
 @param bundleName 本地包名称
 @param modelName 页面名称
 */
- (void)loadBundleName:(NSString*)bundleName modelName:(NSString*)modelName;


///刷新
- (void)reloadPage;
- (void)reloadPageWithProperties:(NSDictionary *)params;

#pragma mark property

/**
 通过url上获取的真实宽度
 */
@property (nonatomic, assign, readonly)CGFloat realWidth;
/**
 通过url上获取的真实高度
 */
@property (nonatomic, assign ,readonly)CGFloat realHeigh;
/**
 包的网络地址
 */
@property (nonatomic, copy, readonly) NSString *bundleURL;
/**
 页面名称
 */
@property (nonatomic, copy, readonly) NSString *modelName;


/**
 RN RootView
 */
@property (nonatomic, strong, readonly)RCTRootView *rootView;

/**
 index.ios.bundle地址
 */
@property (nonatomic, copy, readonly) NSString *indexPath;

/**
 包解压之后文件夹地址
 */
@property (nonatomic, copy, readonly) NSString *bundlePath;

/**
 初始化参数
 */
@property (nonatomic, copy) NSDictionary* initialProperties;

@property(nonatomic,weak) id<ASHRNViewDelegate> viewDelegate;
@end
