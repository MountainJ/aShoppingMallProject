//
//  JayzyButton.h
//  
//
//  Created by jayzhang on 15-4-8.
//  Copyright (c) 2015年 jay张. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JayzyButton : UIButton
//点击后执行Block
//注意，block属性修饰符必须是copy
@property (copy,nonatomic) void (^action)(UIButton *button);


@end
