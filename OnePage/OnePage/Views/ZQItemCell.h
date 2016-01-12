//
//  ZQItemCell.h
//  TsetDemo
//
//  Created by zhangqiang on 15/11/5.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZQHomePageModel;
@interface ZQItemCell : UICollectionViewCell

- (void)writeDataWithModel:(ZQHomePageModel *)model;

@end
