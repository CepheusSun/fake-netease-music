//
//  NEBaseViewModel.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NEBaseViewModel.h"

@implementation NEBaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self viewModelDidLoad];
        [self viewModelLoadNotifications];
    }
    return self;
}

- (void)viewModelDidLoad {
    
}

- (void)viewModelLoadNotifications {
    
}
@end
