//
//  NSString+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SYAdd)

//获取字符串的首字母（不管是汉子还是拼音）
- (NSString*)firstChar;

//字符串是否为空
+ (BOOL)isBlank:(NSString*)str;

/**
 * 返回字符串的 自定义 大小
 */
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;


#pragma mark - 正则表达式
/**
 *  验证邮箱是不是可用
 */
+ (BOOL)isValidateEmail:(NSString *)str;

/**
 *  验证是不是数字
 */
+ (BOOL)isNumber:(NSString *)str;

/**
 *  验证是不是英文
 */
+ (BOOL)isEnglish:(NSString *)str;

/**
 *  验证是不是汉字
 */
+ (BOOL)isChinese:(NSString *)str;

/**
 *  是不是手机号码
 */
+ (BOOL)isMobileNumber:(NSString *)str;

/**
 *  判斷密碼格式
 */
+ (BOOL)isPassword:(NSString *)str;

/**
 *  不包含符号
 */
+ (BOOL)isNoSymbol:(NSString *)str;
@end
