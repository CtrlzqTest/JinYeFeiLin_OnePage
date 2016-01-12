//
//  RequestEntity.m
//  DaoWei
//
//  Created by zhangqiang on 15/10/14.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import "RequestEntity.h"
#import <MJExtension.h>
#import "RequestManager.h"
#import "RestAPI.h"
#import "ZQHomePageModel.h"
//#import "ZQProductListModel.h"

@implementation RequestEntity

+(void)loginWithUserName:(NSString *)userName
                passWord:(NSString *)passWord
                     pid:(NSString *)pid
                 Success:(void(^)(id responsObject, NSError *error))success
                 failure:(void(^)(NSError *error))failure {
    @try {
        NSError *error = nil;
        
        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];

        [paramer setObject:userName forKey:@"loginname"];
        [paramer setObject:passWord forKey:@"pwd"];
        if (pid.length > 0) {
            [paramer setObject:pid forKey:@"openid"];
        }
        [RequestManager startRequest:kLoginAPI paramer:paramer method:RequestMethodGet success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             success(responseObject,error);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
    }
}

// 注册
+(void)registerWithUserName:(NSString *)userName
                   nickName:(NSString *)nickName
                passWord:(NSString *)passWord
                     openID:(NSString *)openId
                 Success:(void(^)(id responsObject, NSError *error))success
                 failure:(void(^)(NSError *error))failure {
    @try {
        NSError *error = nil;
        
        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];
        [paramer setObject:userName forKey:@"USERNAME"];
        [paramer setObject:nickName forKey:@"NAME"];
        [paramer setObject:passWord forKey:@"PASSWORD"];
        [paramer setValue:@"男" forKey:@"SEX"];
        [paramer setObject:openId forKey:@"openid"];
        
        [RequestManager startRequest:kRegisteAPI paramer:paramer method:RequestMethodPost success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             success(responseObject,error);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
    }
}

//第三方登录
+(void)snsLogInRequestWithUserID:(NSString *)userID
                     accessToken:(NSString *)token
                         success:(void(^)(id responseObject,NSError *error))success
                         failure:(void(^)(NSError *error))failure{
    @try {
        NSError *error = nil;
        
        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];
        [paramer setValue:userID forKey:@"openId"];
        [paramer setValue:token forKey:@"accessToken"];
        [paramer setValue:@"1104759378" forKey:@"appId"];
        [paramer setValue:@"zt5q87H5F0Gu3owg" forKey:@"appKey"];
        [RequestManager startRequest:SnsLoginUrlAPI paramer:paramer method:RequestMethodGet success:^(AFHTTPRequestOperation *operation, id responseObject) {
            success(responseObject,error);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failure(error);
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
    }
}

// 首页
+(void)getClassifyDataSuccess:(void(^)(id responsObject, NSError *error))success
                      failure:(void(^)(NSError *error))failure {
    @try {
        NSError *error = nil;
        
        //        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];

        [RequestManager startRequest:kHostUrlString paramer:nil method:RequestMethodGet success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSArray *listData = responseObject[@"list"];
             NSMutableArray *resultArray = [NSMutableArray array];
             resultArray = [ZQHomePageModel mj_objectArrayWithKeyValuesArray:listData];
             success(resultArray,error);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
    }
}

//+(void)getProductDataWithUserID:(NSString *)userID
//                      productID:(NSString *)productID
//                        Success:(void(^)(id responsObject, id paramDict, NSError *error))success
//                           failure:(void(^)(NSError *error))failure {
//    @try {
//        NSError *error = nil;
//        
//        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];
//        [paramer setObject:userID forKey:@"userId"];
//        [paramer setObject:productID forKey:@"tid"];
//        [RequestManager startRequest:kProductListAPI paramer:paramer method:RequestMethodGet success:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             NSArray *listData = responseObject[@"list"];
//             NSMutableArray *resultArray = [NSMutableArray array];
//             resultArray = [ZQProductListModel mj_objectArrayWithKeyValuesArray:listData];
//             NSString *webUrl = [NSString stringWithFormat:@"%@%@",BaseAPI,responseObject[@"url"]];
//             NSString *states = [responseObject objectForKey:@"status"];
//             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//             [dict setObject:webUrl forKey:@"webUrl"];
//             [dict setObject:states forKey:@"status"];
//             success(resultArray,dict,error);
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             failure(error);
//         }];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
//    }
//}

//+(void)getGoodsListDataSuccess:(void(^)(id responsObject, NSError *error))success
//                      failure:(void(^)(NSError *error))failure {
//    @try {
//        NSError *error = nil;
//        
//        [RequestManager startRequest:kGoodsListAPI paramer:nil method:RequestMethodGet success:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             NSArray *list = responseObject[@"list"];
//             NSMutableArray *resultArray = [NSMutableArray array];
//             resultArray = [ZQProductListModel mj_objectArrayWithKeyValuesArray:list];
//             success(resultArray,error);
//         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             failure(error);
//         }];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
//    }
//}

// 收藏
+(void)collectProductWithUserID:(NSString *)userID
                  infopublishId:(NSString *)infopublishId
                        Success:(void(^)(id responsObject, NSError *error))success
                        failure:(void(^)(NSError *error))failure {
    @try {
        NSError *error = nil;
        
        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];
        [paramer setObject:userID forKey:@"userId"];
        [paramer setObject:infopublishId forKey:@"infopublishId"];
        [RequestManager startRequest:kCollectAPI paramer:paramer method:RequestMethodPost success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             success(responseObject,error);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
    }
}

// 收藏列表
+(void)getCollectionListWithUserID:(NSString *)userID
                           Success:(void(^)(id responsObject, NSError *error))success
                           failure:(void(^)(NSError *error))failure {
    @try {
        NSError *error = nil;
        
        NSMutableDictionary *paramer = [NSMutableDictionary dictionary];
        [paramer setObject:userID forKey:@"userId"];
        [RequestManager startRequest:kCollectionListAPI paramer:paramer method:RequestMethodPost success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSArray *listData = responseObject[@"list"];
             NSMutableArray *resultArray = [NSMutableArray array];
             resultArray = [ZQHomePageModel mj_objectArrayWithKeyValuesArray:listData];
             success(resultArray,error);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(error);
         }];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[[exception callStackSymbols] componentsJoinedByString:@"\n"]);
    }
}


@end
