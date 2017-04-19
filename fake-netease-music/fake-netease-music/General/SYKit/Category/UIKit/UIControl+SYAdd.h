//
//  UIControl+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIControl (SYAdd)

- (void)addEventHandler:(void (^)(id sender))handler forControlEvent:(UIControlEvents)controlEvents;

- (void)removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

- (BOOL)hasEventHandlersForControlEvents:(UIControlEvents)controlevent;

@end
NS_ASSUME_NONNULL_END
