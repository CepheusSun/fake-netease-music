//
//  NSArray+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SYAdd)

- (id)safeObjectAtIndex:(NSUInteger)index;

/// 倒序
- (NSArray *)reverse;

/// 排序    大小写敏感
- (NSArray *)objSort;
- (NSArray *)objSort:(id(^)(id obj))callback;
- (NSArray *)objSortAndreverse;

/// 排序    大小写不敏感
- (NSArray *)insensitiveSort;

/// 去除相同的元素, 并获取唯一的数据
- (NSArray *)unique;

#pragma mark - 高阶函数
// 遍历数组
- (void)forEach:(void (^) (id object))block;
// 遍历数组，跟下标相关
- (void)forEachWithIndex:(void (^)(id object, NSUInteger index))block;


- (NSArray *)filter:(BOOL(^)(id obj))block;
- (NSArray *)filterWithIdenx:(BOOL(^)(id obj, NSInteger index))block;
- (NSArray *)map:(id(^)(id obc))block;
- (NSArray *)mapWithIndex:(id(^)(id obc, NSInteger index))block;

// detect 查找, 找出数组中符合某一条件的元素
// 遍历数组，如果数组中的元素执行表达式返回真,就返回这个元素。找到第一个就返回
- (id)detect:(BOOL (^)(id object))block;

/**
 // reduce 合并
 //不知道怎么翻译了,自己理解是这个意思.
 遍历数组中所有元素,并汇总成一个值
 @param block 汇总的规则  没有初始值
 
 NSArray *arr = @[@"1",@"2",@"3"];
 id reduc = [arr reduce:^id(id accumlator, id object) {
 NSLog(@"%@---%@",accumlator,object);
 return [NSString stringWithFormat:@"%@%@",accumlator,object];
 }];
 返回 123
 NSLog(@"%@",reduc);
 */
- (id)reduce:(id (^)(id accumlator, id object))block;

/**
 // reduce 合并
 //不知道怎么翻译了,自己理解是这个意思.
 遍历数组中所有元素,并汇总成一个值
 @param block 汇总的规则  有初始值
 */
- (id)reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;


/// 两个数组合并后去重复
- (NSArray *)objsUnion:(NSArray *)anArray;
// 向集合中删除一个不包含obj集合的所有数据
- (NSArray *)objsIntersection:(NSArray *)anArray;
// 向集合中删除一个obj集合的所有数据。
- (NSArray *)objsDifference:(NSArray *)anArray;

@end


@interface NSMutableArray (SYAdd)

- (void)addObj:(id)obj;

@end
