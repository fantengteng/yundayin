//
//  MyAddressCell.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseCell.h"
#import "MyaddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyAddressCell : TT_BaseCell
@property (nonatomic , strong) UILabel *name_lab;
@property (nonatomic , strong) UILabel *phone_lab;
@property (nonatomic , strong) UILabel *message_lab;
@property (nonatomic , strong) UIButton *delete_btn;
@property (nonatomic , strong) UIButton *bianji_btn;
@property (nonatomic , strong) UILabel *line;
@property (nonatomic , strong) UIView *BG;
@property (nonatomic , strong) TT_Custonbtn *setAddress_btn;
@property (nonatomic , strong) MyaddressModel *model;

@end

NS_ASSUME_NONNULL_END
