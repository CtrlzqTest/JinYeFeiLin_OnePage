//
//  ZQHomePageModel.h
//  OnePage
//
//  Created by zhangqiang on 15/11/19.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQHomePageModel : NSObject

@property(nonatomic,copy)NSString *COVER;
@property(nonatomic,copy)NSString *INFOPUBLISH_ID;
@property(nonatomic,copy)NSString *LINK;
@property(nonatomic,assign)NSInteger TEMPLATE;
@property(nonatomic,strong)NSString *TEXTURL;
@property(nonatomic,strong)NSString *TITLE;
@property(nonatomic,strong)NSString *CATEGORY;
@property(nonatomic,strong)NSString *tid;

@end
