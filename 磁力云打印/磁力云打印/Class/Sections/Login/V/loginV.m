//
//  loginV.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/4.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "loginV.h"

@interface loginV ()

/** 时间 */
@property (nonatomic , assign) CGFloat timeAct;

@end

@implementation loginV


- (IBAction)loginmethed:(id)sender {
    NSInteger num;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (self.phone_tf.text.length == 0 || self.password_tf.text.length == 0) {
        num = 0;
    }else {
        num = 1;
        [dic setValue:self.phone_tf.text forKey:@"mobile"];
        [dic setValue:self.password_tf.text forKey:@"password"];
        [dic setValue:@(2) forKey:@"platform"];
    }
    
    if (self.ViewtapClose) {
        self.ViewtapClose(num, dic);
    }
}
- (IBAction)jumpxieyi:(id)sender {
    if (self.ViewtapClose) {
        self.ViewtapClose(4, @"");
    }
}


- (void)config {
    self.sure_btn.layer.masksToBounds = YES;
    self.sure_btn.layer.cornerRadius  =4;
    self.code_btn.layer.masksToBounds = YES;
    self.code_btn.layer.cornerRadius  = 2;
}




@end
