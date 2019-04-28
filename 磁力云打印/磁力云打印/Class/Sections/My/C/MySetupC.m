//
//  MySetupC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/19.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "MySetupC.h"

@interface MySetupC ()

@end

@implementation MySetupC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Is_hideJuhuazhuan = NO;
 
}
- (IBAction)loginout:(id)sender {
    Eliminate(@"token")
    Eliminate(@"userId")
    [[TabBarTool Share_TabBarTool]CreateLoginC];
}


@end
