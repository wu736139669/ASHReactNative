//
//  ASHRNBundleManagerImpl.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHRNBundleManagerImpl.h"
#import <ZipArchive.h>
#import <AFNetworking.h>
#import "ASHDownFileUtil.h"
@interface ASHRNBundleManagerImpl()
@property (nonatomic, copy) NSString *dirPath;
@property (nonatomic, strong) NSMutableDictionary *callbackMaps;
@end
@implementation ASHRNBundleManagerImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.callbackMaps = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString *)dirPath
{
    if (!_dirPath) {
        _dirPath = [self createRNBundleDirectory];
    }
    return _dirPath;
}

- (NSString *)createRNBundleDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = [paths.firstObject stringByAppendingPathComponent:@"RNView"];
    BOOL isDir = NO;
    BOOL isCreated = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
    if (!isCreated || !isDir) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!success)
        {
            NSAssert(NO, @"create dir error: %@", error.localizedDescription);
            return nil;
        }
    }
    return dirPath;
}
- (NSString *)bundlePathWithURLString:(NSString *)urlString
{
    if (!urlString.length) {
        return nil;
    }
    NSString *lastPathComponent = [urlString componentsSeparatedByString:@"?"].firstObject.lastPathComponent.stringByDeletingPathExtension;
    NSString* zipPath = [urlString componentsSeparatedByString:@"?"].firstObject;
    NSString *fileName = [NSString stringWithFormat:@"%ld_%@",zipPath.hash,lastPathComponent];
    NSString *bundlePath = [self.dirPath stringByAppendingPathComponent:fileName];
    
    return bundlePath;
}
- (BOOL)containBundleURL:(NSURL *)bundleURL
{
    NSString *bundlePath = [self bundlePathWithURLString:bundleURL.absoluteString];
    if (bundlePath) {
        BOOL isDir = NO;
        BOOL hasExists = [[NSFileManager defaultManager] fileExistsAtPath:bundlePath isDirectory:&isDir];
        return (hasExists && isDir);
    }
    else {
        return NO;
    }
}

- (void)downloadWithBundleURL:(NSURL *)bundleURL completedBlock:(nullable void (^)(NSString *, NSString *, NSError * _Nullable))completedBlock
{
    NSString *urlString = bundleURL.absoluteString;
    if (!urlString.length) {
        NSError* error = [NSError errorWithDomain:@"bundle包地址不能为空" code:0 userInfo:nil];
        if (completedBlock) {
            completedBlock(nil, nil, error);
        }
        //        NSAssert(NO, @"bundleURL is nil!!!");
        return;
    }
    
    //文件夹地址
    NSString *bundlePath = [self bundlePathWithURLString:urlString];
    //index文件地址
    NSString *indexPath = [bundlePath stringByAppendingPathComponent:@"index.ios.bundle"];
    
    
    BOOL isDir = NO;
    BOOL hasExists = [[NSFileManager defaultManager] fileExistsAtPath:bundlePath isDirectory:&isDir];
    BOOL hasIndexFile = [[NSFileManager defaultManager] fileExistsAtPath:indexPath];
    
    if (hasExists && isDir && hasIndexFile) {
        if (completedBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completedBlock(indexPath, bundlePath, nil);
            });
        }
    }
    else {
        @synchronized (self) {
            NSMutableArray *callbackBlocks = self.callbackMaps[urlString];
            if (!callbackBlocks) {
                callbackBlocks = [NSMutableArray array];
                self.callbackMaps[urlString] = callbackBlocks;
            }
            if (completedBlock) {
                [callbackBlocks addObject:[completedBlock copy]];
            }
        }
        
        NSString *zipPath = [bundlePath stringByAppendingPathExtension:@"zip"];
        
        [ASHDownFileUtil downLoadWithUrl:urlString filePath:zipPath completedBlock:^(NSString * _Nonnull url, NSString * _Nonnull filePath) {
            NSError *error = nil;
            do{
                BOOL isUnzip = [self unzipFilePath:zipPath];
                if (!isUnzip) {
                    error = [NSError errorWithDomain:[NSString stringWithFormat:@"文件解压 %@ 失败！", zipPath] code:0 userInfo:nil];
                    break;
                }
                BOOL hasIndexFile = [[NSFileManager defaultManager] fileExistsAtPath:indexPath];
                if (!hasIndexFile) {
                    error = [NSError errorWithDomain:[NSString stringWithFormat:@"未找到 index.ios.bundle 文件，%@ ！", indexPath] code:0 userInfo:nil];
                    break;
                }
            }while (0);
            
            [self callbackWithBundleURLString:urlString indexPath:indexPath bundlePath:bundlePath error:error];
            
        } failBlock:^(NSString * _Nonnull url, NSError * _Nonnull error) {
            [self callbackWithBundleURLString:urlString indexPath:indexPath bundlePath:bundlePath error:error];
        }];
    }
}

- (void)callbackWithBundleURLString:(NSString *)urlString indexPath:(NSString *)indexPath bundlePath:(NSString *)bundlePath error:(NSError *)error
{
    NSMutableArray *callbackBlocks = nil;
    @synchronized (self) {
        callbackBlocks = self.callbackMaps[urlString];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        void (^completedBlock)(NSString *indexPath, NSString *bundlePath, NSError *error) = nil;
        for (completedBlock in callbackBlocks) {
            completedBlock(indexPath, bundlePath, error);
        }
    });
}

- (BOOL)unzipFilePath:(NSString *)zipPath
{
    NSString *dirPath = [zipPath stringByDeletingPathExtension];
    ZipArchive* unzipArchive = [[ZipArchive alloc] initWithFileManager:[NSFileManager defaultManager]];
    [unzipArchive UnzipOpenFile:zipPath];
    BOOL isOK = [unzipArchive UnzipFileTo:dirPath overWrite:YES];
    [unzipArchive UnzipCloseFile];
    if (isOK) {
        [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
    }
    return isOK;
}
@end
