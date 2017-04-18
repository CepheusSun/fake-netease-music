//
//  NSObject+toast.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#pragma mark - UIView
@interface UIView (toast)

- (MBProgressHUD *)showMessageHud:(NSString *)message;
- (MBProgressHUD *)showSuccessHud:(NSString *)message;
- (MBProgressHUD *)showFailureHud:(NSString *)message;
- (MBProgressHUD *)showFailureHudWithYOffset:(NSString *)message;
- (MBProgressHUD *)showUpImageSuccessHud:(NSString *)message;

- (MBProgressHUD *)showLoadingHud:(NSString *)message;
- (void)dismissHud;

@end
#pragma mark - UIViewController
@interface UIViewController (toast)

- (MBProgressHUD *)showMessageHud:(NSString *)message;
- (MBProgressHUD *)showSuccessHud:(NSString *)message;
- (MBProgressHUD *)showFailureHud:(NSString *)message;
- (MBProgressHUD *)showFailureHudWithYOffset:(NSString *)message;
- (MBProgressHUD *)showUpImageSuccessHud:(NSString *)message;

- (MBProgressHUD *)showLoadingHud:(NSString *)message;
- (void)dismissHud;

@end

