//
//  ZQHomeViewController.m
//  OnePage
//
//  Created by zhangqiang on 15/11/18.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import "ZQHomeViewController.h"
#import "RequestEntity.h"

#import "ZQItemCell.h"

#import "ZQHomePageModel.h"
#import "ZQClassifyViewController.h"
#import "HoriCardFlowLayout2.h"


static  NSString *const cellID = @"HomePageCell";

@interface ZQHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *_listArray;
    BOOL _isNotBack;
    NSInteger _currentPage; // 当前显示第几页
}

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ZQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requstData];
    [self setupCollectionView];
}

#pragma mark - 私有方法
-(void)requstData
{
    
    _listArray = [[NSMutableArray alloc]initWithCapacity:0];
    __weak typeof (self) weakSelf = self;
    [RequestEntity getClassifyDataSuccess:^(id responsObject, NSError *error) {
        
        _listArray = responsObject;
        [weakSelf.collectionView reloadData];
        _currentPage = _listArray.count;
        

    } failure:^(NSError *error) {
        
    }];
}

- (void)setupCollectionView {
    
    HoriCardFlowLayout2 *layout = [[HoriCardFlowLayout2 alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 84, KWidth, KHeight - 148) collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZQItemCell" bundle:nil] forCellWithReuseIdentifier:cellID];
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.decelerationRate = 0.4;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWidth, 64)];
    //    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:self.collectionView];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZQItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    ZQHomePageModel *model = _listArray[indexPath.row];
    [cell writeDataWithModel:model];
    return cell;
    
}

#pragma mark 选中某个单元时的操作
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _currentPage = _listArray.count - (NSInteger)(self.collectionView.contentOffset.y / self.collectionView.frame.size.height);
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat width = self.collectionView.contentOffset.x + KWidth;
    
    if (width > scrollView.contentSize.width + 40) {
        _isNotBack = YES;
        
        CATransition *transition = [CATransition animation];
        transition.duration = 1.0f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = @"cube";
        transition.subtype = kCATransitionFromRight;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:[[ZQClassifyViewController alloc] init] animated:YES];
    }
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
