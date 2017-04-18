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

//尺寸压缩，质量不变
- (UIImage *)scaleToSize:(CGSize)size;
//质量压缩，尺寸不变，可能压缩不到你要的大小，因为没办法到那么小 这时候你就需要调用尺寸压缩了
- (NSData *)dataInNoSacleLimitBytes:(NSInteger)bytes;
//裁剪图片 取中上部分
- (UIImage *)cutToSize:(CGSize)size;

@end
NS_ASSUME_NONNULL_END
