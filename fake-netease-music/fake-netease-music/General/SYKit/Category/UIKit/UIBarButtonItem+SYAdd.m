//
//  UIBarButtonItem+SYAdd.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "UIBarButtonItem+SYAdd.h"
@import ObjectiveC.runtime;

static const void *SYBarButtonItemBlockKey = &SYBarButtonItemBlockKey;

@interface UIBarButtonItem (BlockPrivate)

- (void)handleAction:(UIBarButtonItem *)sender;

@end
@implementation UIBarButtonItem (SYAdd)

- (instancetype)initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem
                                    handler:(void (^)(id sender))action {
    
    self = [self initWithBarButtonSystemItem:systemItem
                                      target:self
                                      action:@selector(handleAction:)];
    if (!self) return nil;
    objc_setAssociatedObject(self,
                             SYBarButtonItemBlockKey,
                             action,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
                        style:(UIBarButtonItemStyle)style
                      handler:(void (^)(id sender))action {
    
    self = [self initWithImage:image
                         style:style
                        target:self
                        action:@selector(handleAction:)];
    if (!self) return nil;
    objc_setAssociatedObject(self,
                             SYBarButtonItemBlockKey,
                             action,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
          landscapeImagePhone:(UIImage *)landscapeImagePhone
                        style:(UIBarButtonItemStyle)style
                      handler:(void (^)(id sender))action {
    
    self = [self initWithImage:image
           landscapeImagePhone:landscapeImagePhone
                         style:style
                        target:self
                        action:@selector(handleAction:)];
    if (!self) return nil;
    objc_setAssociatedObject(self,
                             SYBarButtonItemBlockKey,
                             action,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                        style:(UIBarButtonItemStyle)style
                      handler:(void (^)(id sender))action {
    
    self = [self initWithTitle:title
                         style:style
                        target:self
                        action:@selector(handleAction:)];
    if (!self) return nil;
    objc_setAssociatedObject(self,
                             SYBarButtonItemBlockKey,
                             action,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (void)handleAction:(UIBarButtonItem *)sender {
    
    void (^block)(id) = objc_getAssociatedObject(self, SYBarButtonItemBlockKey);
    if (block) block(sender);
}


@end
