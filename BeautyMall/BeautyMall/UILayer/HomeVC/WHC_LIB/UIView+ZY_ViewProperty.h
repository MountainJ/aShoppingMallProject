//
//  UIView+ZY_ViewProperty.h
//  ZY_ ContainerView
//
//  Created by JayZY on 15/5/15.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface UIView (ZY_ViewProperty)

- (CGFloat)y;

- (CGFloat)centerY;

- (CGFloat)centerX;

- (CGFloat)maxY;

- (CGFloat)x;

- (CGFloat)maxX;

- (CGPoint)xy;

- (CGFloat)width;

- (CGFloat)height;

- (CGSize)size;

- (void)setY:(CGFloat)Y;

- (void)setX:(CGFloat)X;

- (void)setCenterX:(CGFloat)centerX;

- (void)setCenterY:(CGFloat)centerY;

- (void)setXy:(CGPoint)point;

- (void)setSize:(CGSize)size;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

@end
