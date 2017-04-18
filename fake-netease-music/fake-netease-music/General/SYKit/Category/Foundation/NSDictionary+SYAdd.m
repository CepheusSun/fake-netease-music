//
//  NSDictionary+SYAdd.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NSDictionary+SYAdd.h"
#import "NSArray+SYAdd.h"

@implementation NSDictionary (SYAdd)

- (NSString *)dicURLSort {
    if (self.allKeys == 0) {
        return @"";
    }
    
    NSString *str = @"";
    for (NSString *key in [self.allKeys objSort]) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[self objectForKey:key]]];
    }
    return [str substringToIndex:str.length - 1];
}

- (NSDictionary *)dicAppendingParams:(NSDictionary *)params{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *key in params.allKeys) {
        [dic setObject:[params objectForKey:key] forKey:key];
    }
    return dic;
}

- (NSString *)convertToJSONString {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
        return nil;
    }
    NSString *res = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return res;
    
}
@end
