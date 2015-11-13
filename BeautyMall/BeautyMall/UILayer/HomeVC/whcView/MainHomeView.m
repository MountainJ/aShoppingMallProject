//
//  MainHomeView.m
//  ZY_ ContainerView
//
//  Created by JayZY on 15/5/18.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//


#import "MainHomeView.h"
#import "ZY_BadgeView.h"
#import "UIView+ZY_ViewProperty.h"

#define  KZYContainerBarHeight     (40.0)          //容器条高度
#define  TopWidth  70 //人气推荐按钮宽度
#define  TopHeight 50 //人气推荐按钮高度

#define  Margin  ((AppScreenWidth -TopWidth*4)/5.0) //间隔

#define PICMargin 5.0 //产品展示图片的间隔

#import "ZYAdvertiseModel.h"
#import "ZJLoopScrollView.h"
#import "ZYTopLikeView.h"
#import "DDCollectionViewFlowLayout.h"
#import "ProductCollectionViewCell.h"
#import "ZYheadReusableView.h"
#import "ZYProuductPicModel.h"
#import "ZYProductPicFrame.h"

#import "ZYHomeTimeCell.h"



@interface MainHomeView ()<UICollectionViewDataSource,DDCollectionViewDelegateFlowLayout>
{
    UITableView  * _tableView;
    NSString     * _title;
    NSMutableArray *_adsDataArray;//广告轮播
    NSMutableArray *_topDataArray;//人气推荐
    BOOL _loadMore;
    UIImageView *_backTopView;//回到顶端的图标
    //
}
@property(nonatomic,strong) UICollectionView *collectionView;//pictures show

@end

@implementation MainHomeView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArr topAdData:(NSArray *)adArray topArrayData:(NSArray *)topArray
{
    self = [super initWithFrame:frame ];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _picdataArr= [NSMutableArray arrayWithArray:dataArr];
        _adsDataArray= [NSMutableArray arrayWithArray:adArray];
        _topDataArray = [NSMutableArray arrayWithArray:topArray];
        //collectionVeiw
        [self createUIcollectionView];
        //回到顶端的视图
        [self  createBackTopView];
    }
    return self;
}

#pragma mark - 回到顶端
- (void)createBackTopView
{
    if (!_backTopView) {
        _backTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go_top_btn"]];
        _backTopView.userInteractionEnabled = YES;
        _backTopView.frame =CGRectMake(AppScreenWidth-65, CGRectGetMaxY(_collectionView.frame)-70, 50, 50);
        _backTopView.alpha = 0.8;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTop:)];
        [_backTopView addGestureRecognizer:tap];
        [self addSubview:_backTopView];
        _backTopView.hidden = YES;
    }
}

- (void)backTop:(UITapGestureRecognizer *)sender
{
    [_collectionView scrollRectToVisible:CGRectMake(0, _collectionView.frame.origin.y, AppScreenWidth, _collectionView.frame.size.height) animated:YES];
}

#pragma mark-UICollectionView配置
-(void)createUIcollectionView
{
    WS(weakSelf);
    DDCollectionViewFlowLayout *layout = [[DDCollectionViewFlowLayout alloc] init];
    layout.delegate = self;
    _collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0,0, AppScreenWidth, AppScreenHeight-NavigationBarHeight-TabBarHeight-KZYContainerBarHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor =[UIColor whiteColor];
    [_collectionView registerClass:[ZYHomeTimeCell class] forCellWithReuseIdentifier:@"firstcell"];
    [_collectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:@"mycell"];
    [_collectionView registerClass:[ZYheadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    _collectionView.bounces=YES;
    _collectionView.dataSource =self;
    _collectionView.delegate =self;
    [self addSubview:_collectionView];
    //添加下拉刷新控件;
//    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(headerRefreshView)]) {
//            [weakSelf.delegate headerRefreshView];
//        }
//    }];
    /*添加动态下拉刷新的图*/
    NSArray * refreshImages = @[[UIImage imageNamed:@"image_ego_refresh.png"]];
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self.delegate refreshingAction:@selector(headerRefreshView)];
    // 设置普通状态的动画图片
    [header setImages:refreshImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:refreshImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:refreshImages forState:MJRefreshStateRefreshing];
    _collectionView.header = header;
    
//    _collectionView.header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        if (weakSelf.delegate&&[weakSelf.delegate respondsToSelector:@selector(headerRefreshView)]) {
//            [weakSelf.delegate headerRefreshView];
//        }
//    }];
    
    
    
    
    
    
//    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
//        //
//    }];
}

//- (void)refreshFooter
//{
//    if (self.delegate&&[self.delegate respondsToSelector:@selector(footerRefreshView)]) {
//        [self.delegate footerRefreshView];
//    }
//    
//}

///========UICollectionView的运用============
#pragma mark - UICollectionView DataSource setting

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picdataArr.count+1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(DDCollectionViewFlowLayout *)layout numberOfColumnsInSection:(NSInteger)section{
    return 2;
}

///设置UICollectionView的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        static NSString *identify =@"firstcell";
    ZYHomeTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: identify forIndexPath:indexPath];
        [cell setCellTime:[NSDate date]];
//        cell.backgroundColor =[UIColor redColor];
        return cell;
    }
    else
    {
        static NSString *identifier =@"mycell";

        ProductCollectionViewCell *procell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (_picdataArr.count)
        {
            ZYProductPicFrame *model =_picdataArr[indexPath.row-1];
            [procell setCellFrame:model];
        }
        return procell;
    }
}

///设置view的header和footer 修改后
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reuseableView =nil;
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        
        ZYheadReusableView *backHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        [backHeaderView setFrameAdArray:_adsDataArray topArray:_topDataArray];
        reuseableView =backHeaderView;
        return reuseableView;
    }
    if ([kind isEqual:UICollectionElementKindSectionFooter]) {
        
        UICollectionReusableView *backfooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        if (!_collectionView.footer) {
            _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                //
                //            if (_loadMore&&self.delegate&&[self.delegate respondsToSelector:@selector(footerRefreshView)]) {
                //                [self.delegate footerRefreshView];
                //                _loadMore = NO;
                //            }
            }];
        }
        reuseableView =backfooterView;

        return reuseableView;
    }
    return reuseableView;
}

//#pragma mark--reloadColletionViewItems
//-(void)reloadColletionViewItems
//{
//    
//    NSLog(@"reload");
//    
//}
#pragma mark - UICollectionView Delegate Methods  layout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return PICMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return PICMargin;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.0f, PICMargin, 0.0,PICMargin);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return CGSizeMake(40, 50);
    }
    //图片的宽度    (AppScreenWidth-3*PICMargin)/2;
    ZYProductPicFrame *frameModel = _picdataArr[indexPath.row-1];
    CGSize itemSize = CGSizeMake(20, frameModel.totalItemHeight );
    return itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row<2&&!_backTopView.hidden) {
        
        _backTopView.hidden = YES;
    }
    if (indexPath.row>2&&_backTopView.hidden) {
        
        _backTopView.hidden = NO;
    }
    if (_picdataArr.count - indexPath.row <1)
    {
        _loadMore = YES;
        if (_loadMore&& self.delegate&&[self.delegate respondsToSelector:@selector(footerRefreshView)]) {
            [self.delegate footerRefreshView];
            _loadMore = NO;
        }
    }
    
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(AppScreenWidth, 400);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(AppScreenWidth, 10);
}

//选中cell过后切到详情界面
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0&&self.delegate&&[self.delegate respondsToSelector:@selector(itemCellClicked:)]
) {
        [self.delegate itemCellClicked:_picdataArr[indexPath.row-1]];
//        NSLog(@"section ===%d,row==%d",indexPath.section,indexPath.row);
    }
}

/**
 *  刷新collectionView
 */
- (void)reloadCollectionView
{
    
    [_collectionView reloadData];
    [_collectionView.header endRefreshing];
    
}




@end
