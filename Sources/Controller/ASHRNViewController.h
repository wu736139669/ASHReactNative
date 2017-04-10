//
//  ASHRNViewController.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/10.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASHRNView;
@interface ASHRNViewController : UIViewController

/**
 通过包url初始化
 
 @param bundleURL 包地址
 @return IMYRNViewController
 */
- (instancetype)initWithBundleURL:(NSString *)bundleURL;


/**
 通过包url读取包地址，并且展示 modelName 的内容。
 
 @param bundleURL 包地址
 @param modelName 页面名称
 @return IMYRNViewController
 */
- (instancetype)initWithBundleURL:(NSString *)bundleURL modelName:(NSString *)modelName;


/**
 加载本地bundle包
 
 @param bundleName 本地的bundle名称
 @return IMYRNViewController
 */
- (instancetype)initWithBundleName:(NSString *)bundleName;

/**
 加载本地bundle包
 
 @param bundleName bundleName 本地的bundle名称
 @param modelName 页面名称
 @return IMYRNViewController
 */
- (instancetype)initWithBundleName:(NSString *)bundleName modelName:(NSString *)modelName;
/**
 网络路径
 */
@property (nonatomic, copy, readonly) NSString *bundleURL;

/**
 读取的页面，默认是 index。
 */
@property(nonatomic,copy)NSString *moduleName;

@property(nonatomic,copy)NSString *navTitle;
//本地包名
@property(nonatomic,copy)NSString *bundleName;
@property(nonatomic,strong)NSDictionary *initialProperties;/**< RN要用的参数:请求参数，埋点，自定义... */
@property(nonatomic,assign)BOOL isNeedReloadPage;
@property(nonatomic,strong,readonly)ASHRNView *rnView;
@end
