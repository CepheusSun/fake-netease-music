//
//  SYResponse.h
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYResponse : NSObject

@property (nonatomic ,strong, readonly) NSData * data;
@property (nonatomic, readonly) BOOL isCache;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, copy, readonly) NSDictionary *content;

+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)response:(NSData *)data fromCache:(BOOL)fromCache;
@end
