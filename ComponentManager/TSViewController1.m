//
//  TSViewController1.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/29.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "TSViewController1.h"
#import "CMRouterManager.h"

@interface TSViewController1 ()

@end

@implementation TSViewController1

- (void)setParameters:(NSDictionary *)parameters {
    self.options = parameters;
    NSLog(@"%@", self.options);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"dssdsdds");
    [[CMRouterManager shareManager] router: @"blockTo://shabi" parameters: @"ssdd" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError * _Nonnull error) {

    }];

    void(^block)(id, id) = [[CMRouterManager shareManager] valueForKeyPath: @"routerHandler.routerStorage.routerBlockStorage.shabi"];
    NSLog(@"%@", block);
    block(@"dd", @"dds");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    NSLog(@"gg");
}

@end
