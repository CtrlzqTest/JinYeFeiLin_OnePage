 

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGet,
    RequestMethodPost,
    RequestMethodDelete
};

@interface RequestManager : NSObject
 

+ (void)startRequest:(NSString *)url
             paramer:(NSDictionary *)paramers
              method:(RequestMethod)method
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)uploadFile:(NSData *)postData
 completionHandler:(void(^)(id responseObject))completion
   progressHandler:(void(^)(long long p))progressBlock
    failureHandler:(void(^)(NSError *error))failure; 



+ (void)downloadFileRquestWithFileUrl:(NSString *)fileUrl completionHandler:(void(^)(id responseObject)) completionHandler failerHandler:(void(^)(NSError *error))failerHandler;


@end
