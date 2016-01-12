//
//  RootViewController.m
//  OnePage
//
//  Created by zhangqiang on 15/12/16.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(void)setViewControllers:(NSArray *)viewControllers {
    
    if (_viewControllers != viewControllers) {
        _viewControllers = [viewControllers copy];
    }
}

-(void)setCurrentViewController:(UIViewController *)currentViewController {
    if (_currentViewController != currentViewController) {
        _currentViewController = currentViewController;
        [self.view addSubview:self.currentViewController.view];
    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.currentViewController = self.viewControllers[0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
