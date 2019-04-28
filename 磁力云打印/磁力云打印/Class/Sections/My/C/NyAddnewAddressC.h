//
//  NyAddnewAddressC.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseC.h"
#import "MyaddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NyAddnewAddressC : TT_BaseC
@property (weak, nonatomic) IBOutlet UITextField *name_tf;
@property (weak, nonatomic) IBOutlet UILabel *phone_tg;
@property (weak, nonatomic) IBOutlet UITextField *phoen_tf;
@property (weak, nonatomic) IBOutlet UILabel *address_tf;
@property (weak, nonatomic) IBOutlet UIButton *sure_btn;
@property (weak, nonatomic) IBOutlet UITextField *xiangxi_tf;
@property (nonatomic , strong) MyaddressModel *addressModel;
@end

NS_ASSUME_NONNULL_END
