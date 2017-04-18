//
//  HomeController.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/17.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

#pragma mark - initialize
- (instancetype)init {
    if (self = [super init]) {
        self.menuItemWidth      = [UIScreen mainScreen].bounds.size.width / self.titles.count;
        self.menuViewStyle      = WMMenuViewStyleLine;
        self.titleSizeSelected  = 13.0f;
        self.titleSizeNormal    = 13.0f;
        self.menuHeight         = 47;
        self.menuBGColor        = [UIColor whiteColor];
        self.titleColorNormal   = [UIColor blackColor];
        self.titleColorSelected = [UIColor redColor];
        self.selectIndex        = 0;
        self.progressHeight     = 2;
        self.progressWidth      = 39;
        self.progressColor      = [UIColor redColor];
        self.progressViewIsNaughty = YES;
        self.preloadPolicy      = WMPageControllerPreloadPolicyNeighbour;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现音乐";
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadData];
}

- (NSArray<NSString *> *)titles {
    return @[@"个性推荐", @"歌单", @"主播电台", @"排行榜"];
}

#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu {
    return self.titles.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [[UIViewController alloc] init];
}

@end
