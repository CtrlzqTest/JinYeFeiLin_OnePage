//
//  ZQItemCell.m
//  TsetDemo
//
//  Created by zhangqiang on 15/11/5.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import "ZQItemCell.h"
#import "ZQHomePageModel.h"
#import <UIImageView+WebCache.h>
#import "RestAPI.h"

@interface ZQItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *styleLabel;
@property (weak, nonatomic) IBOutlet UIButton *nameLabel;

@end

@implementation ZQItemCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
}

- (void)writeDataWithModel:(ZQHomePageModel *)model {
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",BaseAPI,model.COVER];
    self.titleLabel.text = model.TITLE;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
    
}

@end
