//
//  ZYMenuView.m
//  BeautyMall
//
//  Created by JayZY on 15/9/15.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYMenuView.h"
#import "ZY_BadgeView.h"
#import "UIView+ZY_ViewProperty.h"

#define  KZYContainerBarHeight     (40.0)          //容器条高度

#import "ZYAdvertiseModel.h"


@interface ZYMenuView ()<UITableViewDataSource , UITableViewDelegate>
{
    UITableView  * _tableView;
    NSString     * _title;
    NSMutableArray *_recomonArray;
}

@end

@implementation ZYMenuView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArr
{
    self = [super initWithFrame:frame ];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        _recomonArray= [NSMutableArray arrayWithArray:dataArr];
        if (!_tableView) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, AppScreenWidth,self.bounds.size.height-TabBarHeight-KZYContainerBarHeight) style:UITableViewStylePlain];
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        
        
    }
    return self;
}


#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0;
}

- (void)reloadView
{
    [_tableView reloadData];
}
#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _recomonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString  * strCell = @"strCell";
    UITableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    ZY_BadgeView  * badgeView = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        
    }
    for (NSInteger i = 0; i < cell.subviews.count; i++) {
        UIView * view = cell.subviews[i];
        if([view isKindOfClass:[ZY_BadgeView class]]){
            [view removeFromSuperview];
            view = nil;
        }
    }
    if([_title isEqualToString:@"ios"]){
        cell.width = [UIScreen mainScreen].bounds.size.width;
        CGRect  cellFrame = cell.frame;
        badgeView = [[ZY_BadgeView alloc]initWithSuperView:cell position:CGPointMake(cellFrame.size.width - 50.0, 15.0) radius:10.0];
        [badgeView setBadgeNumber:indexPath.row];
    }
    if (_recomonArray.count)
    {
        ZYAdvertiseModel *model =_recomonArray[indexPath.row];
        cell.textLabel.text  = model.taobao_title;
    }
    
    
    return cell;
}



@end
