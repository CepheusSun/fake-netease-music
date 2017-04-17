//
//  SYCache.m
//  SYNetwork
//
//  Created by sunny on 2017/4/12.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "SYHTTPCache.h"
#import "SYRequestProtocol.h"

#pragma mark - Cache Object
@interface SYHTTPCacheObject: NSObject<NSCoding>

@property (nonatomic, strong) NSData *content;
@property (nonatomic, strong) NSDate *lastUpdatetime;
@end

@implementation SYHTTPCacheObject

- (instancetype)initWithContent:(NSData *)content {
    self =[super init];
    if (self) {
        self.content = content;
    }
    return self;
}

- (void)setContent:(NSData *)content {
    _content = content;
    self.lastUpdatetime = [NSDate dateWithTimeIntervalSinceNow:0];
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.lastUpdatetime forKey:@"lastUpdatetime"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.lastUpdatetime = [aDecoder decodeObjectForKey:@"lastUpdatetime"];;
    return self;
}

@end

#pragma mark - Memory Cahce
@interface SYHTTPMemoryCache: NSObject

@property (nonatomic ,strong) NSCache *manager;

@end

@implementation SYHTTPMemoryCache

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static SYHTTPMemoryCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SYHTTPMemoryCache alloc] init];
        sharedInstance.manager = [[NSCache alloc] init];
        sharedInstance.manager.countLimit = 1000;
    });
    return sharedInstance;
}

- (void)save:(NSData *)data forkey:(NSString *)key {
    SYHTTPCacheObject *object = [self.manager objectForKey:key];
    if (!object) {
        object = [[SYHTTPCacheObject alloc] initWithContent:data];
    }
    object.content = data;
    [self.manager setObject:object forKey:key];
}

- (NSData *)fetchCacheforkey:(NSString *)key {
    SYHTTPCacheObject *cachedObject = [self.manager objectForKey:key];
    return cachedObject.content;
}

- (void)deleteCacheforkey:(NSString *)key {
    [self.manager removeObjectForKey:key];
}

@end


#pragma mark - DISK Cache
@interface SYHTTPDISKPCache: NSObject

@property (nonatomic ,strong) NSFileManager *fileManager;
@property (nonatomic ,strong) dispatch_queue_t ioQueue;
@property (nonatomic ,copy) NSString* diskPath;
@end

NSString *const defaultCacheName = @"SY_Default";
NSString *const cacheName = @"/com.sy.network.cache.SYNetwork_ObjectiveC/";
NSString *const ioQueueName = @"com.sy.network.cache.ioQueue.";
@implementation SYHTTPDISKPCache

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static SYHTTPDISKPCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SYHTTPDISKPCache alloc] init];
        sharedInstance.fileManager = [NSFileManager defaultManager];
        sharedInstance.ioQueue = dispatch_queue_create(cacheName.UTF8String, DISPATCH_QUEUE_CONCURRENT);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true);
        sharedInstance.diskPath = [NSString stringWithFormat:@"%@%@",paths.firstObject, cacheName];
        dispatch_sync(sharedInstance.ioQueue, ^{
            [sharedInstance.fileManager createDirectoryAtPath:sharedInstance.diskPath withIntermediateDirectories:true attributes:nil error:nil];
        });
    });
    return sharedInstance;
}

- (void)save:(NSData *)data forKey:(NSString *)key {
    NSString *path = [NSString stringWithFormat:@"%@%@",self.diskPath, [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    NSError *error;
    if ([self.fileManager fileExistsAtPath:path]) {
        [self.fileManager removeItemAtPath:path error:nil];
    }
    [data writeToFile:path options:NSAtomicWrite error:&error];
    
}

- (NSData *)fetchForKey:(NSString *)key {
    NSString *path = [NSString stringWithFormat:@"%@%@",self.diskPath, [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    if ([self.fileManager fileExistsAtPath:path]) {
        NSData *data = [self.fileManager contentsAtPath:path];
        return data;
    }
    return nil;
}

- (void)deleteForKey:(NSString *)key {
    NSString *path = [NSString stringWithFormat:@"%@%@",self.diskPath, [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    [self.fileManager removeItemAtPath:path error:nil];
}

- (void)clear {
    [self.fileManager removeItemAtPath:self.diskPath error:nil];
    dispatch_sync(self.ioQueue, ^{
        [self.fileManager createDirectoryAtPath:self.diskPath withIntermediateDirectories:true attributes:nil error:nil];
    });
}

@end


@interface SYHTTPCache()

@end

@implementation SYHTTPCache

+ (void)save:(NSData *)data forRequest:(id<SYRequestProtocol>)request {
    SYHTTPCacheObject *object = [[SYHTTPCacheObject alloc] initWithContent:data];
    NSMutableData *cacheData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:cacheData];
    NSString *key = [self keyForRequest:request];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    [[SYHTTPMemoryCache shared] save:cacheData forkey:key];
    [[SYHTTPDISKPCache shared] save:cacheData forKey:key];
}

+ (void)delectDataForRequest:(id<SYRequestProtocol>)request {
    NSString *key = [self keyForRequest:request];
    [[SYHTTPMemoryCache shared] deleteCacheforkey:key];
    [[SYHTTPDISKPCache shared] deleteForKey:key];
}

+ (NSData *)fetchDataForRequest:(id<SYRequestProtocol>)request {
    NSString *key = [self keyForRequest:request];
    NSData * data = [[SYHTTPMemoryCache shared] fetchCacheforkey:key];
    BOOL memory = NO;
    if (data) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        SYHTTPCacheObject *object = [unarchiver decodeObjectForKey:key];
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:object.lastUpdatetime];
        if (object.content == nil || time > request.cacheTimeInterval) {
            [self delectDataForRequest:request];
            return nil;
        }
        memory = YES;
        return object.content;
    }
    data = [[SYHTTPDISKPCache shared] fetchForKey:key];
    if (data) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        SYHTTPCacheObject *object = [unarchiver decodeObjectForKey:key];
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:object.lastUpdatetime];
        if (object.content == nil || time > request.cacheTimeInterval) {
            [self delectDataForRequest:request];
            return nil;
        }
        if (!memory) {
   
            [[SYHTTPMemoryCache shared] save:data forkey:key];
        }
        return object.content;
    }
    return nil;
}

+ (NSString *)keyForRequest:(id<SYRequestProtocol>)request {
    NSArray *sortedArray = [[request.parameters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    __block NSString *sortedString = @"";
    [sortedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        sortedString = [sortedString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",[obj lowercaseString], request.parameters[obj]]];
    }];
    return [NSString stringWithFormat:@"%@%@?%@",request.url,request.path,sortedString];
}

@end
