//
//  SYFrameLayout.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "SYFrameLayout.h"
#import "UIDevice+SYAdd.h"

iPhoneModel currentModel() {
    CGFloat temp = ScreenHeight();
    if (temp == 480) return iPhoneModel_iPhone4;
    if (temp == 568) return iPhoneModel_iPhone5;
    if (temp == 667) return iPhoneModel_iPhone6;
    if (temp == 736) return iPhoneModel_iPhone6p;
    else return iPhoneModel_iPad;
}

CGFloat ScreenHeight() {
    if (UIDevice.isHorizontal) {
        return [UIScreen mainScreen].bounds.size.width;
    }
    return [UIScreen mainScreen].bounds.size.height;
}

CGFloat ScreenWidth() {
    if (UIDevice.isHorizontal) {
        return [UIScreen mainScreen].bounds.size.height;
    }
    return [UIScreen mainScreen].bounds.size.width;
}

CGFloat layoutFont(CGFloat iPhone6Size) {
    CGFloat newFont = 0;
    switch (currentModel()) {
        case iPhoneModel_iPhone4:
            newFont = iPhone6Size * (320.0 / 375.0);
        case iPhoneModel_iPhone5:
            newFont = iPhone6Size * (320.0 / 375.0);
        case iPhoneModel_iPhone6:
            newFont = iPhone6Size;
        case iPhoneModel_iPhone6p:
            newFont = iPhone6Size * (414.0 / 375.0);
        default:
            newFont = iPhone6Size * 1.2;
    }
    return newFont;
}

CGFloat layoutHorizontal(CGFloat iPhone6Size) {
    CGFloat newWidth = 0;
    switch (currentModel()) {
        case iPhoneModel_iPhone4:
            newWidth = iPhone6Size * (320.0 / 667.0);
        case iPhoneModel_iPhone5:
            newWidth = iPhone6Size * (320.0 / 375.0);
        case iPhoneModel_iPhone6:
            newWidth = iPhone6Size;
        case iPhoneModel_iPhone6p:
            newWidth = iPhone6Size * (414.0 / 375.0);
        default:
            newWidth = iPhone6Size * (768.0 / 375.0 * 0.9);
    }
    return newWidth;
}


CGFloat layoutVertical(CGFloat iPhone6Size) {
    CGFloat newHeight = 0;
    switch (currentModel()) {
        case iPhoneModel_iPhone4:
            newHeight = iPhone6Size * (480.0 / 667.0);
        case iPhoneModel_iPhone5:
            newHeight = iPhone6Size * (568.0 / 667.0);
        case iPhoneModel_iPhone6:
            newHeight = iPhone6Size;
        case iPhoneModel_iPhone6p:
            newHeight = iPhone6Size * (736.0 / 667.0);
        default:
            newHeight = iPhone6Size * (1024.0 / 667.0 * 0.9);
    }
    return newHeight;
}

