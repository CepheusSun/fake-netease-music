//
//  NSArray+SYAdd.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NSArray+SYAdd.h"

@implementation NSArray (SYAdd)

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (index < self.count){
        id object = [self objectAtIndex:index];
        if ([object isKindOfClass:[NSNull class]])
            return nil;
        return object;
    }
    return nil;
}

- (NSArray *)reverse {
    if (self.count <= 1) {
        return self;
    }
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)objSort {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSArray *)objSort:(id (^)(id))callback {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [callback(obj1) compare:callback(obj2)];
    }];
}

- (NSArray *)objSortAndreverse {
    return [[self objSort] reverse];
}

- (NSArray *)insensitiveSort {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 caseInsensitiveCompare:obj2];
    }];
}

- (NSArray *)objsUnique:(id (^)(id))callback {
    __block NSMutableDictionary *uniques = [[NSMutableDictionary alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([uniques objectForKey:callback(obj)] == nil){
            [uniques setValue:obj forKey:callback(obj)];
        }
    }];
    return [uniques allValues];
}

- (NSArray *)unique {
    return [[self objsUnique:^id(id obj) {
        return obj;
    }] objSort];
}
#pragma mark - 高阶函数

- (void)forEach:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj);
    }];
}


- (void)forEachWithIndex:(void (^)(id, NSUInteger))block {
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx);
    }];
}

- (NSArray *)filter:(BOOL(^)(id obj))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray *)filterWithIdenx:(BOOL (^)(id, NSInteger))block {
    __block NSMutableArray *arrays = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        if (block(obj,idx)) {
            [arrays addObject:obj];
        }
    }];
    return arrays;
}

- (NSArray *)map:(id (^)(id))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:block(obj) ?: [NSNull null]];
    }];
    return [array copy];
}

- (NSArray *)mapWithIndex:(id(^)(id obc, NSInteger index))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:block(obj, idx) ?: [NSNull null]];
    }];
    return [array copy];
}

- (id)detect:(BOOL (^)(id))block {
    for (id object in self) {
        if (block(object))
            return object;
    }
    return nil;
}

- (id)reduce:(id (^)(id accumlator, id object))block {
    return [self reduce:nil withBlock:block];
}

- (id)reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block {
    __block id accumlator = initial;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        accumlator = accumlator ? block(accumlator, obj) :obj;
    }];
    return accumlator;
}

- (NSArray *)objsUnion:(NSArray *)anArray {
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    [set1 unionOrderedSet:set2];
    return set1.array.copy;
}

- (NSArray *)objsIntersection:(NSArray *)anArray {
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    [set1 intersectOrderedSet:set2];
    return set1.array.copy;
}

- (NSArray *)objsDifference:(NSArray *)anArray {
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    [set1 minusOrderedSet:set2];
    return set1.array.copy;
}


@end

@implementation NSMutableArray (SYAdd)

-(void)addObj:(id)i{
    if (i!=nil) {
        [self addObject:i];
    }
}

@end
