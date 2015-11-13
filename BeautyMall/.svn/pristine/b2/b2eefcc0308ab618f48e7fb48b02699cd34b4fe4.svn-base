//
//  ZYHttpDownloadTool.h
//  BeautyMall
//
//  Created by JayZY on 15/9/7.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//  该类进行网络数据下载或上传

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface ZYHttpDownloadTool : NSObject


/**
 *  get请求
 *
 *  @param URLString  基本URL
 *  @param parameters 参数
 *  @param success    成功的回调
 *  @param failure    失败的回掉
 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)( NSError *error))failure;



@end
