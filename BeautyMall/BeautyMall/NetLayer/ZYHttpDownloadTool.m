//
//  ZYHttpDownloadTool.m
//  BeautyMall
//
//  Created by JayZY on 15/9/7.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYHttpDownloadTool.h"

@implementation ZYHttpDownloadTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *manager  = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:URLString parameters:parameters
 success:^(AFHTTPRequestOperation *operation, id responseObject) {
     if (success)
     {
    NSDictionary *responseDict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         success(responseDict);
     }
     
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     if (failure) {
         failure(error);
     }
 }];
    
}


@end
