//
//  UIImage+SYAdd.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN void imageWriteToSavedPhotosAlbum(UIImage *image, void(^completetionBlock)(NSError *));

UIKIT_EXTERN void saveVideoAtURLToSavedPhotosAlbum(NSURL *videoURL, void(^completetionBlock)(NSError *));

@interface UIImage (SYAdd)



@end
NS_ASSUME_NONNULL_END
