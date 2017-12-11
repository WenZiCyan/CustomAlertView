//
//  AlertViewController.m
//  AlertView
//
//  Created by Fangjw on 2017/11/27.
//  Copyright © 2017年 Fangjw. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()


@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [UIView animateWithDuration:[coordinator transitionDuration] animations:^{
        
        if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
            
            
        } else {
            NSLog(@"竖屏");
            
        }
        
    }];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //Landscape : 横屏  Portrait: 竖屏
    
    // 传入一个方向值, 如果是横屏, 则返回YES
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        
    }
    
    // 传入一个方向值, 如果是竖屏, 则返回YES
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        NSLog(@"竖屏");
    }
}

@end
