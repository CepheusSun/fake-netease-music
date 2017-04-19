//
//  NSDictionary+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SYAdd)

/**
 对字典中的键值进行‘类URL’排序
 例如: {
 a : 111,
 e : 222,
 c : 333,
 b : 444
 }
 => a=111&b=444&c=333&e=222
 */
- (NSString *)dicURLSort;

/**
 添加另外的字典的数据
 */
- (NSDictionary *)dicAppendingParams:(NSDictionary *)params;


/**
 转换成Json数组
 */
- (NSString *)convertToJSONString;
@end
