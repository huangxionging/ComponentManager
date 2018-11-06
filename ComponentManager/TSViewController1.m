//
//  TSViewController1.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/29.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "TSViewController1.h"

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
