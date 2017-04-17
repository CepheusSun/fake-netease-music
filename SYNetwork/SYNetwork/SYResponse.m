//
//  SYResponse.m
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "SYResponse.h"


@interface SYResponse ()

@property (nonatomic ,strong) NSData * data;
@property (nonatomic) BOOL isCache;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) NSDictionary *content;

@end

@implementation SYResponse

+ (instancetype)response:(NSData *)data fromCache:(BOOL)fromCache {
    SYResponse *res = [[SYResponse alloc] init];
    res.data = data;
    res.isCache = fromCache;
    NSError *error;
    res.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    res.error = error;
    return res;
}
@end
