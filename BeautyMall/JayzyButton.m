//
//  JayzyButton.m
//  
//
//  Created by jayzhang on 15-4-8.
//  Copyright (c) 2015年 jay张. All rights reserved.
//

#import "JayzyButton.h"

@implementation JayzyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
-(void)btnClick:(UIButton *) button
{
    if (self.action) {
        self.action(self);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
