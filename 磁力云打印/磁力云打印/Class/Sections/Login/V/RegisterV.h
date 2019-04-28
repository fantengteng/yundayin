//
//  RegisterV.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/4.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseV.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterV : TT_BaseV
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;

@end

NS_ASSUME_NONNULL_END
