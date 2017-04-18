//
//  CALayer+SYAdd.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "CALayer+SYAdd.h"
#import <UIKit/UIKit.h>

@implementation CALayer (SYAdd)

- (void)setBorderColorWithUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end
