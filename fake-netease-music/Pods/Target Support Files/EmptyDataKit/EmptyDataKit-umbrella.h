#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "EmptyDataKit.h"
#import "NSObject+Swizzling.h"
#import "UICollectionView+NoData.h"
#import "UITableView+NoData.h"

FOUNDATION_EXPORT double EmptyDataKitVersionNumber;
FOUNDATION_EXPORT const unsigned char EmptyDataKitVersionString[];

