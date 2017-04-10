//
//  ASHRNViewController.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/10.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ASHRNViewController.h"
#import "ASHRNView.h"
#import "NSString+Util.h"
#import <MBProgressHUD.h>
@interface ASHRNViewController ()<ASHRNViewDelegate>
@property(nonatomic,strong)ASHRNView *rnView;
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;
@end

@implementation ASHRNViewController

@synthesize bundleURL = _bundleURL;
@synthesize moduleName = _moduleName;

- (instancetype)initWithBundleURL:(NSString *)bundleURL
{
    NSDictionary* dic = [bundleURL ash_queryDictionary];
    NSString* model = dic[@"model"];
    if (!model.length) {
        model = @"index";
    }
    return [self initWithBundleURL:bundleURL modelName:model];
}

- (instancetype)initWithBundleURL:(NSString *)bundleURL modelName:(NSString *)modelName
{
    self = [super init];
    if (self) {
        _bundleURL = bundleURL;
        if (!modelName.length) {
            NSDictionary* dic = [bundleURL ash_queryDictionary];
            modelName = dic[@"model"];
            if (!modelName.length) {
                modelName = @"index";
            }
        }
        _moduleName = modelName;
    }
    return self;
}

- (instancetype)initWithBundleName:(NSString *)bundleName
{
    return [self initWithBundleName:bundleName modelName:@"index"];
}
- (instancetype)initWithBundleName:(NSString *)bundleName modelName:(NSString *)modelName
{
    self = [super init];
    if (self) {
        _bundleName = bundleName;
        _moduleName = modelName;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setupRNView];
    [self setupCaptionView];
}

- (void)setupRNView
{
    self.rnView = [[ASHRNView alloc] initWithFrame:self.view.bounds];
    self.rnView.viewDelegate = self;
    self.rnView.initialProperties = self.initialProperties;
    self.rnView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.rnView];
}

- (void)setupCaptionView
{
    self.indicatorView = [UIActivityIndicatorView new];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navTitle) {
        self.navigationItem.title = self.navTitle;
    }
    
    [self loadBundle];
}

- (void)loadBundle
{
    if (self.bundleURL) {
        [self.rnView loadBundle:self.bundleURL withModelName:self.moduleName];
    } else {
        [self.rnView loadBundleName:self.bundleName modelName:self.moduleName];
    }
}

#pragma mark IMYRNViewDelegate

- (void)rnViewDidCreated:(ASHRNView *)weexView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)rnView:(ASHRNView *)rnView didFailed:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)rnViewDidRenderFinish:(ASHRNView *)rnView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
