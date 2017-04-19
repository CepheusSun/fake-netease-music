//
//  RankViewController.m
//  fake-netease-music
//
//  Created by QianYuZ on 2017/4/17.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "RankViewController.h"
#import "NERankViewModel.h"

@interface RankViewController ()

@property (nonatomic ,strong) NERankViewModel *viewModel;
@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[NERankViewModel alloc] init];
    
    [RACObserve(self.viewModel, data) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    } error:^(NSError *error) {
        NSLog(@"2");
    } completed:^{
        NSLog(@"3");
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.viewModel.sourceCommand execute:nil];
}

@end
