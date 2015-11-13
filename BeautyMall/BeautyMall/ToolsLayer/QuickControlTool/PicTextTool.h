//
//  PicTextButton.h
//  TestPictureText
//
//  Created by JayZY on 15/9/7.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@class PicTextTool;

@protocol PicTextToolDelegate <NSObject>
/**
 *  按钮点击
 *
 *  @param btn 传入按钮
 */
- (void)buttonClickHere:(UIButton *)btn;

@end

@interface PicTextTool : NSObject

/**
 *  自动添加上图下文按钮到视图上,实现点击
 *
 *  @param pictureArray 存储图片的数组
 *  @param textArray    存储文字的数组
 *  @param fontSize     文字的字体
 *  @param parentView   添加到哪一个视图上
*  @param buttonSize   按钮的尺寸
*  @param iconSize     显示图标的尺寸
*  @param target       添加对象
*  @param firstTag     第一个按钮的tag
*/
+(void)creatPictureTextClickButton :(NSArray *)pictureArray textArray:(NSArray *)textArray textFont:(CGFloat)fontSize addToView :(UIView *)parentView buttonSize: (CGSize )buttonSize  imgIconSize :(CGSize )iconSize  toTarget:(id)target buttonFirstTag:(NSInteger)firstTag;

/**
*  自动添加左图右文按钮到视图上,实现点击
*
*  @param pictureArray
*  @param textArray
*  @param fontSize
*  @param parentView
*  @param buttonSize
*  @param iconSize
*  @param target
*  @param firstTag
*/
+(void)creatLeftPictureRightTextPicture :(NSArray *)pictureArray textArray:(NSArray *)textArray textFont:(CGFloat)fontSize addToView :(UIView *)parentView buttonSize: (CGSize )buttonSize  imgIconSize :(CGSize )iconSize  toTarget:(id)target buttonFirstTag:(NSInteger)firstTag;

/**
 *  URL添加上图下文按钮到视图上,实现点击
 *
 *  @param pictureArray 存储图片的数组
 *  @param textArray    存储文字的数组
 *  @param fontSize     文字的字体
 *  @param parentView   添加到哪一个视图上
 *  @param buttonSize   按钮的尺寸
 *  @param iconSize     显示图标的尺寸
 *  @param target       添加对象
 *  @param firstTag     第一个按钮的tag
 */
+(void)creatPictureTextClickButtonWithURL :(NSArray *)pictureArrayURL textArray:(NSArray *)textArray textFont:(CGFloat)fontSize addToView :(UIView *)parentView buttonSize: (CGSize )buttonSize  imgIconSize :(CGSize )iconSize  toTarget:(id)target buttonFirstTag:(NSInteger)firstTag;

@end
