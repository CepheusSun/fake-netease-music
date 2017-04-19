//
//  NERankViewModel.h
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NEBaseViewModel.h"

@interface NERankViewModel : NEBaseViewModel

@property (nonatomic ,strong, readonly) RACCommand *sourceCommand;

@property (nonatomic ,strong) id data;
@end
