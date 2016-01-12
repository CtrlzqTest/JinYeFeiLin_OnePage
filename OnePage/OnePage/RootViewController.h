//
//  RootViewController.h
//  OnePage
//
//  Created by zhangqiang on 15/12/16.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import "BaseViewController.h"

@interface RootViewController : BaseViewController

@property(nonatomic,strong)NSArray<__kindof UIViewController *> *viewControllers;

@property(nonatomic,strong)UIViewController *currentViewController;

@end
