//
//  NERankViewModel.m
//  fake-netease-music
//
//  Created by sunny on 2017/4/18.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

#import "NERankViewModel.h"
#import "NEBaseRequest.h"

@interface Rank_List_Api : NEBaseRequest

@end

@implementation Rank_List_Api

- (NSString *)path {
    return @"/top_list?idx=6";
}
//
//- (NSDictionary *)parameters {
//    return @{@"idx":@"6"};
//}

- (SYRequestType)requestType {
    return SYRequestTypePost;
}
@end

@interface NERankViewModel ()


@end

@implementation NERankViewModel
{
    NSUInteger *_page;
}
- (void)viewModelDidLoad {
    [super viewModelDidLoad];
    @weakify(self);
    _sourceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
         return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[SYHTTPManager shared] request:[[Rank_List_Api alloc] init] success:^(SYResponse *result) {
                @strongify(self);
                [subscriber sendNext:result];
                [subscriber sendCompleted];
            } failure:^(NSString *errorString) {
                self.data = errorString;
                [subscriber sendError:[NSError errorWithDomain:errorString code:-1000 userInfo:nil]];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}


@end

