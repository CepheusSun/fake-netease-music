//
//  AppDelegate.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/17.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "NENavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[NENavigationController alloc] initWithRootViewController:[[HomeController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
