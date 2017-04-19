//
//  NSObject+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SYAdd)


+ (void)sy_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector;


+ (void)sy_swizzleClassSelector:(SEL)origSelector
                swizzleSelector:(SEL)swizzleSelector;

@end
