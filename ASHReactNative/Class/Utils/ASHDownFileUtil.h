//
//  ASHDownFileUtil.h
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASHDownFileUtil : NSObject


NS_ASSUME_NONNULL_BEGIN
/**
 下载文件

 @param url 文件地址
 @param filePath 保存地址
 @param completedBlock 成功回调
 @param failBlock 失败回调
 */
+(void)downLoadWithUrl:( NSString* )url filePath:(NSString*)filePath completedBlock:(void(^)(NSString* url, NSString*filePath))completedBlock failBlock:(void(^)(NSString* url, NSError* error))failBlock;
@end

NS_ASSUME_NONNULL_END
