//
//  RequestEntity.h
//  DaoWei
//
//  Created by zhangqiang on 15/10/14.
//  Copyright © 2015年 zhangqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestEntity : NSObject

/**
 *  登录
 *
 *  @param userName 用户名
 *  @param passWord 密码
 *  @param pid
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
+(void)loginWithUserName:(NSString *)userName
                passWord:(NSString *)passWord
                     pid:(NSString *)pid
                 Success:(void(^)(id responsObject, NSError *error))success
                 failure:(void(^)(NSError *error))failure;

/**
 *  注册
 *
 *  @param userName 用户名
 *  @param nickName 昵称
 *  @param passWord 密码
 *  @param openid   授权返回的usid
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
+(void)registerWithUserName:(NSString *)userName
                   nickName:(NSString *)nickName
                   passWord:(NSString *)passWord
                     openID:(NSString *)openId
                    Success:(void(^)(id responsObject, NSError *error))success
                    failure:(void(^)(NSError *error))failure ;

/**
 *  收藏
 *
 *  @param userID        用户ID
 *  @param infopublishId 大标题ID
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 */
+(void)collectProductWithUserID:(NSString *)userID
                  infopublishId:(NSString *)infopublishId
                        Success:(void(^)(id responsObject, NSError *error))success
                        failure:(void(^)(NSError *error))failure;

/**
 *  收藏列表
 *
 *  @param userID  用户ID
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)getCollectionListWithUserID:(NSString *)userID
                        Success:(void(^)(id responsObject, NSError *error))success
                        failure:(void(^)(NSError *error))failure;
/**
 *  第三方登录
 *
 *  @param userID  <#userID description#>
 *  @param token   <#token description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)snsLogInRequestWithUserID:(NSString *)userID
                     accessToken:(NSString *)token
                         success:(void(^)(id responseObject,NSError *error))success
                         failure:(void(^)(NSError *error))failure;
/**
 *  获取分类列表数据
 *
 *  @param success 成功Block
 *  @param failure 失败Block
 */
+(void)getClassifyDataSuccess:(void(^)(id responsObject, NSError *error))success
                      failure:(void(^)(NSError *error))failure;
/**
 *  获取产品列表
 *
 *  @param category category
 *  @param productID 参数id
 *  @param success  success description
 *  @param failure  failure description
 */
+(void)getProductDataWithUserID:(NSString *)userID
                      productID:(NSString *)productID
                        Success:(void(^)(id responsObject, id paramDict, NSError *error))success
                        failure:(void(^)(NSError *error))failure ;
/**
 *  闪购列表
 *
 *  @param success 成功Block
 *  @param failure 失败Block
 */
+(void)getGoodsListDataSuccess:(void(^)(id responsObject, NSError *error))success
                       failure:(void(^)(NSError *error))failure;
@end
