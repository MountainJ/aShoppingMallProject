//
//  ZY_ContainerBarItem.h
//  ZY_ ContainerView
//
//  Created by JayZY on 15/5/15.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "UIView+ZY_ViewProperty.h"

typedef enum _ZYBarItemStyle{
    TITLE_SHOW,               //首页展示类型
    EDIT_SHOW,                //编辑展示类型
    ADD_SHOW                  //编辑添加展示类型
}ZYBarItemStyle;

@class ZY_ContainerBarItem;
@protocol ZY_ContainerBarItemDelegate <NSObject>

@optional
- (void)ZYContainerBarItem:(ZY_ContainerBarItem*)barItem clickIndex:(NSInteger)index animated:(BOOL)animated;

- (void)ZYContainerBarItem:(ZY_ContainerBarItem *)barItem clickDeleteBtn:(UIButton*)sender index:(NSInteger)index;
@end

@interface ZY_ContainerBarItem : UIView

@property (nonatomic , assign)   id<ZY_ContainerBarItemDelegate>delegate;

@property (nonatomic , strong)   NSString  * title;                 //标题
@property (nonatomic , assign)   NSInteger   index;                 //下标
@property (nonatomic , assign)   CGFloat     normalFontSize;        //正常字体大小
@property (nonatomic , assign)   CGFloat     selectedFontSize;      //选择时字体大小
@property (nonatomic , strong)   UIColor   * normalTitleColor;      //正常标题颜色
@property (nonatomic , strong)   UIColor   * selectedTitleColor;    //选择标题颜色
@property (nonatomic , strong)   UIColor   * normalBackgroundColor; //正常背景颜色
@property (nonatomic , strong)   UIColor   * selectedBackgroundColor;//选择背景颜色

@property (nonatomic , assign)   BOOL        selected;

- (instancetype)initWithFrame:(CGRect)frame Style:(ZYBarItemStyle)style;

- (void)addBadgeViewWithPosition:(CGPoint)position radius:(CGFloat)radius withBadgeNumber:(NSInteger)badgeNumber; 

- (void)removeBadgeView;

- (void)dynamicChangeBackgroudColor:(UIColor *)color;

- (void)dynamicChangeTextColor:(UIColor *)color;

- (void)dynamicChangeTextSize:(UIFont *)font;

- (void)setItemStyle:(ZYBarItemStyle)style;

- (void)startEdit;

- (void)stopEdit;
@end
