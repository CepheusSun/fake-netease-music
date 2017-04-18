//
//  SYMarcos.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#ifndef SYMarcos_h
#define SYMarcos_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

#define DEVICE_WIDTH (([UIDevice currentDevice].orientation \
== UIDeviceOrientationLandscapeLeft || \
[UIDevice currentDevice].orientation \
== UIDeviceOrientationLandscapeRight) \
? SCREEN_WIDTH : SCREEN_HEIGHT)

#define DEVICE_HEIGHT (([UIDevice currentDevice].orientation \
== UIDeviceOrientationLandscapeLeft || \
[UIDevice currentDevice].orientation \
== UIDeviceOrientationLandscapeRight) \
? SCREEN_HEIGHT : SCREEN_WIDTH)

#endif /* SYMarcos_h */
