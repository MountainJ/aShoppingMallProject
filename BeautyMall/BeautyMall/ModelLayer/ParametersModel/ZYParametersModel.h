//
//  ZYParametersModel.h
//  BeautyMall
//
//  Created by JayZY on 15/9/8.
//  Copyright (c) 2015年 jayZY. All rights reserved.
// 网络请求参数模型层

#import <Foundation/Foundation.h>

@interface ZYParametersModel : NSObject

@property (nonatomic,copy) NSString *sid;

@property (nonatomic,copy) NSString *yk_pid;

@property (nonatomic,copy) NSString *yk_cc;

@property (nonatomic,copy) NSString *yk_cvc;

@property (nonatomic,copy) NSString *cursor;
//数据数量
@property (nonatomic,copy) NSString *count;

@property (nonatomic,copy) NSString *yk_appid;

@property (nonatomic,copy) NSString *yk_user_id;

@property (nonatomic,copy) NSString *type;
/**
 *  系统版本
 */
@property (nonatomic,copy) NSString *yk_cbv;

@property (nonatomic,copy) NSString *taobao_num_iid;
/**
 *  
 */
@property (nonatomic,copy) NSString *object_id;


@end
