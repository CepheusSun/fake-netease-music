//
//  UIImage+SYAdd.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "UIImage+SYAdd.h"

@implementation UIImage (SYAdd)

+ (void)image:(UIImage *)image
didFinishSavingWitherror:(NSError *)error
  contextInfo:(void *)contextInfo
{
    void(^block)(NSError *) = (__bridge_transfer id)contextInfo;
    if (!block) return;
    block(error);
}

+ (void)videoAtPath:(NSString *)videoPath
didFinishSavingWithError:(NSError *)error
        contextInfo:(void *)contextInfo
{
    void(^block)(NSError *) = (__bridge_transfer id)contextInfo;
    if (!block) return;
    block(error);
}

@end

void imageWriteToSavedPhotosAlbum(UIImage *image,
                                  void(^completionBlock)(NSError *))
{
    void *blockAsContext = (__bridge_retained void *)[completionBlock copy];
    
    UIImageWriteToSavedPhotosAlbum(image,
                                   UIImage.class,
                                   @selector(image:didFinishSavingWitherror:contextInfo:),
                                   blockAsContext);
}

void saveVideoAtURLToSavedPhotosAlbum(NSURL *videoURL,
                                      void(^completetionBlock)(NSError *))
{
    
    void *blockAscontext = (__bridge_retained void *)[completetionBlock copy];
    UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path,
                                        UIImage.class,
                                        @selector(videoAtPath:didFinishSavingWithError:contextInfo:),
                                        blockAscontext);
    
    
}
