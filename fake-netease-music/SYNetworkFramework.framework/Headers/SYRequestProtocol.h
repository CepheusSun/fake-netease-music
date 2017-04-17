//
//  SYRequestProtocol.h
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYResponse;
typedef NS_ENUM(NSUInteger, SYResponseStatus) {
    SYResponseStatusSuccess,
    SYResponseStatusUnusual,
    SYResponseStatusFailure,
};

typedef NS_ENUM(NSUInteger, SYRequestType) {
    SYRequestTypeGet,
    SYRequestTypePost,
};

@protocol SYRequestProtocol <NSObject>

@required
- (NSString *)url;
- (NSString *)path;
- (SYRequestType)requestType;
- (NSTimeInterval)cacheTimeInterval;
- (NSDictionary *)parameters;
- (NSURLRequest*)urlRequest;
- (NSTimeInterval)timeoutInterval;

- (BOOL)showStatusBarIndicator;
- (BOOL)isIllegal:(SYResponse *)response;

- (NSDictionary *)remakeParam;
- (NSData *)decode:(NSData *)responseObject;
@end
