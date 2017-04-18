//
//  UIColor+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGBBytes(r,g,b) [UIColor \
colorWithRed:   ((CGFloat)(r)/255.0) \
green:          ((CGFloat)(g)/255.0) \
blue:           ((CGFloat)(b)/255.0) \
alpha:          1.0]

#define UIColorFromRGBHex(rgbValue) [UIColor \
colorWithRed:   ((CGFloat)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
green:          ((CGFloat)(((rgbValue) & 0xFF00) >> 8))/255.0 \
blue:           ((CGFloat) ((rgbValue) & 0xFF))/255.0 \
alpha:          1.0]

@interface UIColor (SYAdd)

/// 十六进制转化 UICOlor
+ (UIColor *)colorWithHex:(unsigned int)hex;
+ (UIColor *)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

///  颜色转化成UIImage
- (UIImage *)colorImage;
- (UIImage *)colorImagewithSize:(CGSize)size;

///  随机色
+ (UIColor *)randomColor;

/**
 渐变颜色
 @param fromColor From Color
 @param toColor To Color
 @param height Height
 @return Return a UIColor Instance with gradient
 */
+ (UIColor *)gradientFrom:(UIColor *)fromColor
                       to:(UIColor *)toColor
                   height:(CGFloat)height;
@end
