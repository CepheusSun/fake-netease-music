//
//  NSObject+SYAdd.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NSObject+SYAdd.h"

@import ObjectiveC.runtime;
@implementation NSObject (SYAdd)

+ (void)sy_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector {
    
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSelector);
    
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }else {
        class_replaceMethod(self, swizzleSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
}

+ (void)sy_swizzleClassSelector:(SEL)origSelector
                swizzleSelector:(SEL)swizzleSelector {
    
    Method origMethod = class_getClassMethod(self, origSelector);
    Method swizzleMethod = class_getClassMethod(self, swizzleSelector);
    
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}


@end
