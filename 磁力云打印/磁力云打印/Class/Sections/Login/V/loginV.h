//
//  loginV.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/4.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_BaseV.h"
NS_ASSUME_NONNULL_BEGIN

@interface loginV : TT_BaseV
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
@property (weak, nonatomic) IBOutlet UIButton *sure_btn;
@property (weak, nonatomic) IBOutlet UIButton *code_btn;
@property (weak, nonatomic) IBOutlet UITextField *Code_tf;
@property (nonatomic , strong) NSTimer *timer;
@end

NS_ASSUME_NONNULL_END
