//
//  SYHTTPManager.h
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SYRequestReachabilityStatus) {
    SYRequestReachabilityStatusUnknow = 0,
    SYRequestReachabilityStatusNotReachable,
    SYRequestReachabilityStatusViaWWAN,
    SYRequestReachabilityStatusViaWiFi
};

@protocol SYRequestProtocol;
@class SYResponse;
typedef void(^SYRequestSuccessBlock)(SYResponse* result);
typedef void(^SYRequestFailureBlock)(NSString *errorString);
@interface SYHTTPManager : NSObject


@property (nonatomic ,assign ,getter=isReachability) BOOL reachability;
@property (nonatomic, assign, readonly) SYRequestReachabilityStatus reachabilityStatus;


+ (instancetype)shared;

- (NSURLSessionDataTask *)request:(id<SYRequestProtocol>)request
                          success:(SYRequestSuccessBlock)success
                          failure:(SYRequestFailureBlock)failure;

@end
