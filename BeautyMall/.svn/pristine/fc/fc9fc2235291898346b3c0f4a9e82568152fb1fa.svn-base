//
//  ZY_ContainerView.h
//  ZY_ ContainerView
//
//  Created by JayZY on 15/5/15.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "ZY_ContainerBar.h"

@class ZY_ContainerView;
@class MainHomeView;

@protocol  ZY_ContainerViewDelegate<NSObject>

@required

- (NSArray *)ZY_ContainerView:(ZY_ContainerView *)containerView updateContainerViewLayoutWithTitlesArr:(NSArray *)titlesArr;

//- (void)ZY_ContainerView:(ZY_ContainerView *)containerView loadContentForCurrentView:(UIView *)currentView currentIndex:(NSInteger)index;

- (void)reloadCollectionView:(MainHomeView *)mainView;

@end

@interface ZY_ContainerView : UIView

@property (nonatomic , assign) id<ZY_ContainerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame param:(ZY_ContainerBarParam*)param;

+ (void)saveContainerBarTitlesArr:(NSArray *)titlesArr laterTitlesArr:(NSArray *)laterTitlesArr;

// mark:读取缓存中要显示的标题组
+ (NSArray *)readContainerBarTitlesArr;
// mark:读取缓存中待显示的标题组
+ (NSArray *)readContainerBarLaterTitlesArr;
@end
