//
//  NEBaseRequest.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/17.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NEBaseRequest.h"

@implementation NEBaseRequest

- (NSString *)url {
    return @"http://localhost:3000/";
}

- (NSString *)path {
    return @"";
}

- (NSDictionary *)parameters {
    return @{};
}

- (NSTimeInterval)cacheTimeInterval {
    return 0;
}

- (NSDictionary *)remakeParam {
    return self.parameters;
}

- (NSURLRequest *)urlRequest {
    return nil;
}

- (NSTimeInterval)timeoutInterval {
    return 20;
}

- (NSData *)decode:(NSData *)responseObject {
    return responseObject;
}

- (SYRequestType)requestType {
    return SYRequestTypePost;
}

- (BOOL)showStatusBarIndicator {
    return NO;
}

- (BOOL)isIllegal:(SYResponse *)response {
    return YES;
}
@end
