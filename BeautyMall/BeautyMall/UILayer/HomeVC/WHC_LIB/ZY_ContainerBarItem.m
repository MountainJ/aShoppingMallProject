//
//  ZY_ContainerBarItem.m
//  ZY_ ContainerView
//
//  Created by JayZY on 15/5/15.
//  Copyright (c) 2015年 JayZY. All rights reserved.
//



#import "ZY_ContainerBarItem.h"
#import "ZY_BadgeView.h"
#define KZY_DeleteButtonSize (15.0)          //删除按钮尺寸
#define KZY_RotateAngle (5.0)                //编辑时抖动角度
#define KZY_RotateDuring (0.1)               //编辑时抖动周期
#define KZY_BadgeSize    (20.0)
@interface ZY_ContainerBarItem ()<ZY_BadgeViewDelegate>{
    
    UIButton              * _barItemBtn;      //选项按钮
    UIButton              * _deleteBtn;       //删除按钮
    ZY_BadgeView         * _badgeView;       //数字视图
    ZYBarItemStyle         _itemStyle;       //按钮样式
    
    UITapGestureRecognizer * _tapGesture;     //单击手势
}

@end

@implementation ZY_ContainerBarItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUILayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Style:(ZYBarItemStyle)style{
    self = [super initWithFrame:frame];
    if(self){
        _itemStyle = style;
        [self initUILayout];
    }
    return self;
}

- (void)initSet{
    _barItemBtn.backgroundColor = [UIColor whiteColor];
    _barItemBtn.layer.cornerRadius = self.height / 2.0;
    _barItemBtn.layer.borderColor = [UIColor grayColor].CGColor;
    _barItemBtn.layer.borderWidth = 0.5;
    _barItemBtn.layer.masksToBounds = YES;
}
- (void)initUILayout{
    self.backgroundColor = [UIColor clearColor];
    _barItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _barItemBtn.frame = self.bounds;
    [_barItemBtn addTarget:self action:@selector(clickBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_barItemBtn];
    
    if(_itemStyle == ADD_SHOW ||
       _itemStyle == EDIT_SHOW){
        [self initSet];
        if(_itemStyle == EDIT_SHOW){
            [self addDeleteButton];
        }
    }
}

- (void)addDeleteButton{
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(0.0, -1.0, KZY_DeleteButtonSize, KZY_DeleteButtonSize);
    _deleteBtn.backgroundColor = [UIColor grayColor];
    _deleteBtn.layer.cornerRadius = KZY_DeleteButtonSize / 2.0;
    _deleteBtn.layer.masksToBounds = YES;
    [_deleteBtn setTitle:@"×" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [_deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteBtn];
    _deleteBtn.hidden = YES;
}

- (void)addBadgeViewWithPosition:(CGPoint)position radius:(CGFloat)radius withBadgeNumber:(NSInteger)badgeNumber{
    ZY_BadgeView  * badgeView = [[ZY_BadgeView alloc]initWithSuperView:self position:position radius:radius];
    badgeView.delegate = self;
    [badgeView setBadgeNumber:badgeNumber];
    
    _tapGesture  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [badgeView addGestureRecognizer:_tapGesture];
}

- (void)removeBadgeView{
    if(_tapGesture){
        [self removeGestureRecognizer:_tapGesture];
    }
    for (ZY_BadgeView * badgeView in self.subviews) {
        if([badgeView isKindOfClass:[ZY_BadgeView class]]){
            [badgeView removeSelf];
        }
    }
}

#pragma mark - handleTapGesture - 
- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture{
    [self clickBarItem:_barItemBtn];
}

#pragma mark - propertyOverride -

- (void)setItemStyle:(ZYBarItemStyle)style{
    _itemStyle = style;
    if(_itemStyle == EDIT_SHOW){
        if(_deleteBtn){
            if (![self.subviews containsObject:_deleteBtn]) {
                [self addSubview:_deleteBtn];
            }
        }else{
            [self addDeleteButton];
        }
    }else{
        if(_deleteBtn){
            if([self.subviews containsObject:_deleteBtn]){
                [_deleteBtn removeFromSuperview];
                
            }
            _deleteBtn = nil;
        }
    }
}

- (void)setTitle:(NSString *)title{
    if(title == nil){
        title = @"";
    }
    _title = nil;
    _title = title;
    [_barItemBtn setTitle:_title forState:UIControlStateNormal];
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    _barItemBtn.tag = index;
}

- (void)setNormalFontSize:(CGFloat)normalFontSize{
    _normalFontSize = normalFontSize;
    _barItemBtn.titleLabel.font = [UIFont boldSystemFontOfSize:_normalFontSize];
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor{
    _normalTitleColor = nil;
    _normalTitleColor = normalTitleColor;
    [_barItemBtn setTitleColor:normalTitleColor forState:UIControlStateNormal];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    _selectedTitleColor = nil;
    _selectedTitleColor = selectedTitleColor;
}

- (void)dynamicChangeBackgroudColor:(UIColor *)color{
    _barItemBtn.backgroundColor = color;
}

- (void)dynamicChangeTextColor:(UIColor *)color{
    [_barItemBtn setTitleColor:color forState:UIControlStateNormal];
}

- (void)dynamicChangeTextSize:(UIFont *)font{
    _barItemBtn.titleLabel.font = font;
}


- (void)startEdit{
    _deleteBtn.hidden = NO;
    double (^angle)(double) = ^(double deg) {
        return deg / 180.0 * M_PI;
    };
    CABasicAnimation * ba = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ba.fromValue = @(angle(-KZY_RotateAngle));
    ba.toValue = @(angle(KZY_RotateAngle));
    ba.repeatCount = MAXFLOAT;
    ba.duration = KZY_RotateDuring;
    ba.autoreverses = YES;
    [self.layer addAnimation:ba forKey:nil];
}

- (void)stopEdit{
    _deleteBtn.hidden = YES;
    [self.layer removeAllAnimations];
}

#pragma mark - barItemAction -
- (void)clickBarItem:(UIButton*)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(ZYContainerBarItem:clickIndex: animated:)]){
        [_delegate ZYContainerBarItem:self clickIndex:sender.tag animated:YES];
    }
}

- (void)clickDeleteBtn:(UIButton*)sender{
    sender.tag = _index;
    if(_delegate && [_delegate respondsToSelector:@selector(ZYContainerBarItem:clickDeleteBtn: index:)]){
        [_delegate ZYContainerBarItem:self clickDeleteBtn:sender index:_index];
    }
}

#pragma mark - other - 
- (void)setSelected:(BOOL)selected{
    _barItemBtn.selected = selected;
    if(selected){
        [self dynamicChangeTextSize:[UIFont boldSystemFontOfSize:_selectedFontSize]];
        [self dynamicChangeTextColor:_selectedTitleColor];
        _barItemBtn.backgroundColor = _selectedBackgroundColor;
    }else{
        [self dynamicChangeTextSize:[UIFont boldSystemFontOfSize:_normalFontSize]];
        [self dynamicChangeTextColor:_normalTitleColor];
        _barItemBtn.backgroundColor = _normalBackgroundColor;
    }
}

- (BOOL)selected{
    return _barItemBtn.selected;
}

#pragma mark - ZY_BadgeViewDelegate -
- (void)ZY_BadgeViewWillStartDrag{
 
}

- (void)ZY_BadgeViewDidEndDrag{

}

- (void)ZY_BadgeViewDidRemoveFromSuperViewWithIndex:(NSInteger)index{
    NSLog(@"已经移除BadgeIndex = %d",index);
}
@end
