//
//  MainHomeView.h
//  ZY_ ContainerView
//
//  Created by JayZY on 15/5/18.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//



#import <UIKit/UIKit.h>

@class MainHomeView;
@class ZYProductPicFrame;
@protocol MainHomeViewDelegate <NSObject>

- (void)MainHomeView :(MainHomeView *)mainHomeView buttonClick:(UIButton *)button;
/**
 *  刷新表格
 */
- (void)headerRefreshView;
/**
 *  加载更多
 */
- (void)footerRefreshView;
/**
 *  cell单击
 *
 *  @param itemCell
 */
- (void)itemCellClicked :(ZYProductPicFrame *)cellModel;

@end


@interface MainHomeView : UIView

/**
 *  创建图片展示视图
 *
 *  @param frame   坐标
 *  @param dataArr 图片数据
 *  @param adArray 广告图片数据
 *
 *  @return MainHomeView
 */
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArr topAdData:(NSArray *)adArray topArrayData:(NSArray *)topArray;


//
@property (nonatomic ,assign) id<MainHomeViewDelegate >delegate;
/**
 *  主页产品图片
 */
@property (nonatomic ,strong)  NSMutableArray *picdataArr;





/**
 *  刷新collectionView
 */
- (void)reloadCollectionView;

@end
