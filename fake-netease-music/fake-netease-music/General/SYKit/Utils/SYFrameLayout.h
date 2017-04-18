//
//  SYFrameLayout.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, iPhoneModel) {
    iPhoneModel_iPhone4,
    iPhoneModel_iPhone5,
    iPhoneModel_iPhone6,
    iPhoneModel_iPhone6p,
    iPhoneModel_iPad
};

UIKIT_EXTERN iPhoneModel currentModel();

UIKIT_EXTERN CGFloat ScreenHeight();

UIKIT_EXTERN CGFloat ScreenWidth();

UIKIT_EXTERN CGFloat layoutFont(CGFloat iPhone6Size);

UIKIT_EXTERN CGFloat layoutVertical(CGFloat iPhone6Size);

UIKIT_EXTERN CGFloat layoutHorizontal(CGFloat iPhone6Size);
