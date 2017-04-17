//
//  SYCache.h
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SYRequestProtocol;

@interface SYHTTPCache : NSObject


+ (void)save:(NSData *)data forRequest:(id<SYRequestProtocol>)request;

+ (void)delectDataForRequest:(id<SYRequestProtocol>)request;

+ (NSData *)fetchDataForRequest:(id<SYRequestProtocol>)request;

@end
