//
//  RegisterV.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/4.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "RegisterV.h"

@implementation RegisterV


- (IBAction)sure:(id)sender {
    NSInteger num;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (self.phone_tf.text.length == 0 || self.password_tf.text.length == 0) {
        num = 0;
    }else {
        num = 1;
        [dic setValue:self.phone_tf.text forKey:@"mobile"];
        [dic setValue:self.password_tf.text forKey:@"password"];
    }
    
    if (self.ViewtapClose) {
        self.ViewtapClose(num, dic);
    }
    
}

@end
