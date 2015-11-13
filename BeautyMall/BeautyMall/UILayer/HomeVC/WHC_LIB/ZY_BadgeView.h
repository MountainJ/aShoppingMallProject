//
//  ZY_BadgeView.h
//  ZY_ ContainerView
//
//  Created by JayZY on 15/6/9.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//



#import <UIKit/UIKit.h>

@class ZY_BadgeView;
@protocol  ZY_BadgeViewDelegate<NSObject>

- (void)ZY_BadgeViewDidRemoveFromSuperViewWithIndex:(NSInteger)index;

@optional
- (void)ZY_BadgeViewWillStartDrag;

- (void)ZY_BadgeViewDidEndDrag;
@end

@interface ZY_BadgeView : UIView
@property (nonatomic , assign)NSInteger    index;
@property (nonatomic , assign)id<ZY_BadgeViewDelegate> delegate;

- (instancetype)initWithSuperView:(UIView *)superView position:(CGPoint)position radius:(CGFloat)radius;

//设置标签数字
- (NSInteger)setBadgeNumber:(NSInteger)number;

//设置有效吸附距离
- (void)setValidAttachDistance:(CGFloat)validAttachDistance;

//设置最大圆心距离(拖拽断开距离默认半径11陪)
- (void)setMaxCircleDistance:(CGFloat)maxCircleDistance;

//手动销毁自己
- (void)removeSelf;
@end
