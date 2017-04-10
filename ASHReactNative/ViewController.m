//
//  ViewController.m
//  ASHReactNative
//
//  Created by xmfish on 17/4/7.
//  Copyright © 2017年 ash. All rights reserved.
//

#import "ViewController.h"
#import "ASHReactNative.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 80, 100, 64);
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)btnAction:(id)sender
{
//    [[ASHReactNative shareInstance] pushRNViewControllerWithBundleName:@"main.jsbundle" modelName:@"index"];
    [[ASHReactNative shareInstance] pushRNViewControllerWithURL:@"http://static.seeyouyima.com/rn.meiyou.com/meiyou-rn.zip?model=tips"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
