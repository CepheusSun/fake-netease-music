//
//  SYHTTPManager.m
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "SYHTTPManager.h"
#import "SYRequestProtocol.h"
#import "AFNetworking.h"
#import <NetworkExtension/NetworkExtension.h>
#import "SYResponse.h"
#import "SYHTTPCache.h"

@interface SYHTTPManager ()

@property (nonatomic ,strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic ,assign) NSUInteger *currentRequestCount;

@end

@implementation SYHTTPManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static SYHTTPManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[SYHTTPManager alloc] init];
        [manager startNetworkStateMonitoring];
    });
    return manager;
}

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", @"text/javascript", nil];
        // 限制最大请求量
        self.sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    }
    return _sessionManager;
}

- (NSURLSessionDataTask *)request:(id<SYRequestProtocol>)request
        success:(SYRequestSuccessBlock)success
        failure:(SYRequestFailureBlock)failure {
    // 操作缓存
    NSData *responseObj = [SYHTTPCache fetchDataForRequest:request];
    if (responseObj) {
        success([SYResponse response:responseObj fromCache:YES]);
        return nil;
    }
    
    NSMutableURLRequest *mutableRequest = request.urlRequest.mutableCopy;
    if (!request.urlRequest) {
        NSString *typeString = @"";
        switch (request.requestType) {
            case SYRequestTypeGet:
                typeString = @"GET";
                break;
            case SYRequestTypePost:
                typeString = @"POST";
                break;
        }
        
        mutableRequest = [self.sessionManager.requestSerializer
                          requestWithMethod:typeString
                          URLString:[NSString stringWithFormat:@"%@/%@",request.url,request.path]
                          parameters:request.remakeParam
                          error:nil];
        mutableRequest.timeoutInterval = request.timeoutInterval;
    }
    
    if (request.showStatusBarIndicator) { self.currentRequestCount ++;}
    NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:mutableRequest
                                                            completionHandler:^
                                      (NSURLResponse *response, id responseObject, NSError * error) {
                                          if (request.showStatusBarIndicator) { self.currentRequestCount --;}

                                          if (error) {
                                              if (failure) {
                                                  failure(error.localizedDescription);
                                              }
                                          } else {
                                              NSData * responseData = [request decode:responseObject];
                                              SYResponse *response = [SYResponse response:responseData fromCache:NO];
                                              if ([request isIllegal:response]) {
                                                  if (request.cacheTimeInterval > 0) {
                                                      // 存入缓存
                                                      [SYHTTPCache save:response.data forRequest:request];
                                                  }
                                                  if (success) {
                                                      success(response);
                                                  }
                                              } else {
                                                  if (failure) {
                                                      failure(response.error.localizedDescription);
                                                  }
                                              }
                                          }
                                      }];
    
        [dataTask resume];
        return dataTask;
}


#pragma mark - 网络 Indicator
- (void)setCurrentRequestCount:(NSUInteger *)currentRequestCount {
    _currentRequestCount = currentRequestCount;
    if (currentRequestCount > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        });
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }
}

#pragma mark - 监测网络状态

-(BOOL)isReachability {
    if (self.reachabilityStatus != SYRequestReachabilityStatusNotReachable) {
        return YES;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    return NO;
}

- (void)startNetworkStateMonitoring {
    [self.sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                _reachabilityStatus = SYRequestReachabilityStatusUnknow;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _reachabilityStatus = SYRequestReachabilityStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _reachabilityStatus = SYRequestReachabilityStatusViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _reachabilityStatus = SYRequestReachabilityStatusViaWiFi;
                break;
            default:
                break;
        }
    }];
    [self.sessionManager.reachabilityManager startMonitoring];
}


@end
