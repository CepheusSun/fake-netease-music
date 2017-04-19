//
//  NSDate+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -

#define SECOND	(1)
#define MINUTE	(60 * SECOND)
#define HOUR	(60 * MINUTE)
#define DAY		(24 * HOUR)
#define MONTH	(30 * DAY)
#define YEAR	(12 * MONTH)

#pragma mark -

@interface NSDate (SYAdd)

//时间格式化
@property (nonatomic, readonly) NSInteger	year;
@property (nonatomic, readonly) NSInteger	month;
@property (nonatomic, readonly) NSInteger	day;
@property (nonatomic, readonly) NSInteger	hour;
@property (nonatomic, readonly) NSInteger	minute;
@property (nonatomic, readonly) NSInteger	second;
@property (nonatomic, readonly) NSInteger	weekday;

- (NSDate*)firstTime;
- (NSDate*)lastTime;

+ (NSDate*)dateWithFormat:(NSString *)format;

- (NSString*)weekdayStr;

+ (NSString*)timeInterval1970_13:(NSDate*)date;
+ (NSString*)timeInterval1970_10:(NSDate*)date;
+ (NSDate*)currentDateCMT;







@end
