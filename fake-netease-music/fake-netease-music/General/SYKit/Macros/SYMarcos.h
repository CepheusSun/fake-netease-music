//
//  SYMarcos.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#ifndef SYMarcos_h
#define SYMarcos_h


#endif /* SYMarcos_h */

#pragma mark - ===================UserDefaults===========================

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark - ===================GCD===========================

#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


#pragma mark - ===================打印日志===========================
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"✪✪✪✪✪✪: %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#ifdef DEBUG
#define D_NSLog(format, ...) NSLog((@"✪✪✪✪✪✪: " format), ## __VA_ARGS__)
#else
#define D_NSLog(format, ...)
#endif

#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)
#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])
#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)

