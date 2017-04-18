//
//  NEBaseViewModel.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NEBaseViewModel : NSObject

- (void)viewModelDidLoad __attribute__((objc_requires_super));

- (void)viewModelLoadNotifications __attribute__((objc_requires_super));

@end
