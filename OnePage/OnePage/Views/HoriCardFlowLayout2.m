//
//  HoriCardFlowLayout2.m
//  OnePage
//
//  Created by zhangqiang on 15/12/17.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import "HoriCardFlowLayout2.h"

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.1
#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)

@interface HoriCardFlowLayout2(){
    NSInteger _count;
}
/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation HoriCardFlowLayout2


-(instancetype)init {
    
    if (self = [super init]) {
        CGSize size = CGSizeMake(kScreen_Width, kScreen_Height - 148);
        self.itemSize = CGSizeMake(size.width - 180,size.height - 220);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 30;
        self.sectionInset = UIEdgeInsetsMake(0, (size.width - self.itemSize.width) / 2.0, 0, (size.width - self.itemSize.width) / 2.0);
    }
    return self;
}
-(NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {

        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            
            distance = ABS(distance);
            
            if (distance < kScreen_Width / 2 + self.itemSize.width) {
                CGFloat zoom = 1 + ZOOM_FACTOR * (1 - distance / ACTIVE_DISTANCE);
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0 , -zoom * 25, 0);
                attributes.alpha = zoom - ZOOM_FACTOR;
            }
            
        }
    }
    return array;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat hori_X;
    // 屏幕中线坐标hori_X
    hori_X = self.collectionView.contentOffset.x + self.collectionView.frame.size.width / 2.0;
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        attr.center = CGPointMake(self.collectionView.frame.size.width / 2.0, self.collectionView.frame.size.height / 2.0 - 30);
//    }

    return attr;
    
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    ZQLog(@"------%f",velocity.x);
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.frame) / 2.0);
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:targetRect];
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in attrs) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);

}

@end
