 

#import "RequestManager.h"
#import "RestAPI.h"
#import <AFNetworking.h>

@implementation RequestManager


+ (AFHTTPRequestOperationManager *)requestManagerWithBaseURL:(NSString *)baseURLString {
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return manager;
}

+ (void)startRequest:(NSString *)url
             paramer:(NSDictionary *)paramers
              method:(RequestMethod)method
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager = [self requestManagerWithBaseURL:BaseAPI];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    AFJSONResponseSerializer* jsonResponseSerializer = [AFJSONResponseSerializer serializer];
//    jsonResponseSerializer.removesKeysWithNullValues = YES;
//    jsonResponseSerializer.readingOptions = NSJSONReadingAllowFragments;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //添加一个可以接受的类型，因为有时候返回值不为json
    NSMutableSet *acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes mutableCopy];
    [acceptableContentTypes addObject:@"text/json; charset=utf-8"];
//    manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    
    NSString *path = [BaseAPI stringByAppendingString:url]; 
    
    if (method == RequestMethodGet) {
        
        [manager GET:path parameters:paramers success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(operation.response.statusCode != 200) {
                failure(operation, error);
                return ;
            }
            operation.responseSerializer = [AFHTTPResponseSerializer serializer];
            id object = operation.responseObject;
            if (object) {
                object = [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding];
                success(operation, object);
            } else {
                failure(operation, error);
            }
        }];
        
    }else if (method == RequestMethodPost) {
        NSLog(@"paramers:%@",paramers);
        [manager POST:path parameters:paramers success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(operation.response.statusCode != 200) {
                NSLog(@"%@",operation.responseObject);
                failure(operation, error);
                return ;
            }
            id object = operation.responseObject; 
            if (object) {
                object = [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding];
                success(operation, object);
            } else {
                failure(operation, error);
            }
        }];
        
    } else if (method == RequestMethodDelete) { 
        
        [manager DELETE:path parameters:paramers success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
            
            if(operation.response.statusCode != 200) {
                failure(operation, error);
                return ;
            }
//            operation.responseSerializer = [AFJSONResponseSerializer serializer];
            id object = operation.responseObject;
            NSLog(@"del respose obj %@", object);
            if (object) {
                object = [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding];
                success(operation, object);
            } else {
                NSLog(@"del fail obj %@", object);
                failure(operation, error);
            }
        }];
        
    }
}

+ (void)uploadFile:(NSData *)postData completionHandler:(void(^)(id responseObject))completion progressHandler:(void(^)(long long p))progressBlock failureHandler:(void(^)(NSError *error))failure {
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//    NSString *path = [BaseAPI stringByAppendingString:UploadImageAPI];
    NSString *path = nil;
    NSMutableURLRequest *request =
    [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:postData
                                    name:@"bin"
                                fileName:@"image.jpg"
                                mimeType:@"application/octet-stream"];
    } error:nil];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
//    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPRequestOperation *operation =
    [operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSUInteger statusCode = operation.response.statusCode;
          if (statusCode == 200) {
              completion(responseObject);
          } else {
              failure(nil);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          failure(error);
      }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress = ((long double)totalBytesWritten / (long double)totalBytesExpectedToWrite);
        NSLog(@"bytesWritten %lu totalBytesWritten %lld totalBytesExpectedToWrite %lld",(unsigned long)bytesWritten,totalBytesWritten, totalBytesExpectedToWrite);
        if (progressBlock) {
            progressBlock(progress);
        }
    }];
    
    [operation start];
}

+ (void)downloadFileRquestWithFileUrl:(NSString *)fileUrl completionHandler:(void(^)(id responseObject)) completionHandler failerHandler:(void(^)(NSError *error))failerHandler{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        completionHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failerHandler(error);
    }]; 
    
    [operation start];
}

@end
