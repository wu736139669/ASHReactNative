//
//  ASHDownFileUtil.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHDownFileUtil.h"
#import <AFNetworking.h>
@implementation ASHDownFileUtil

+(void)downLoadWithUrl:(NSString *)url filePath:(NSString *)filePath completedBlock:(void (^)(NSString * _Nonnull, NSString * _Nonnull))completedBlock failBlock:(void (^)(NSString * _Nonnull, NSError * _Nonnull))failBlock
{
    if (!url || !url.length) {
        if (failBlock) {
            failBlock(@"", [NSError errorWithDomain:@"下载地址为空" code:0 userInfo:nil]);
        }
    }
    AFHTTPSessionManager* sessionManager = [AFHTTPSessionManager manager];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask* task = [sessionManager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        return [NSURL fileURLWithPath:filePath];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            if (completedBlock) {
                completedBlock(url, [filePath absoluteString]);
            }
        }else{
            if (failBlock) {
                failBlock(url, error);
            }
        }
    }];
    [task resume];
}
@end
