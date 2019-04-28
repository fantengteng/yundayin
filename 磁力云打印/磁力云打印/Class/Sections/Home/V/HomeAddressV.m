//
//  HomeAddressV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/18.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeAddressV.h"

@interface HomeAddressV ()

@property (nonatomic , strong) UILabel *name_LAB;

@property (nonatomic , strong) UILabel *address_LAB;

@property (nonatomic , strong) UILabel *phone_LAB;

@property (nonatomic , strong) UIButton *addAddressbtn;

@end

@implementation HomeAddressV

#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法

- (void)tap_addAddress {
    if (self.ViewtapClose) {
        self.ViewtapClose(0, @"");
    }
}

#pragma mark 公开方法

- (void)configData:(MyaddressModel *)data {
    if (data) {
        [self configAddressData:data];
    }else {
        [self configaddAddress];
    }
}

- (void)tt_setupViews {
    self.backgroundColor = Col_FFF;
}
#pragma mark 私有方法

- (void)configAddressData:(MyaddressModel *)data {
    [self removeAllSubviews];
    [self addSubview:self.name_LAB];
    [self addSubview:self.phone_LAB];
    [self addSubview:self.address_LAB];
    self.name_LAB.text = data.name;
    self.phone_LAB.text = data.phone;
    self.address_LAB.text = data.detailAddress;
    [self configAddressFrameS];
}

- (void)configAddressFrameS {
    self.name_LAB.sd_layout
    .leftSpaceToView(self, 20)
    .topSpaceToView(self, 17)
    .widthIs(150)
    .heightIs(16);
    
    self.phone_LAB.sd_layout
    .topEqualToView(self.name_LAB)
    .leftSpaceToView(self.name_LAB, 0)
    .rightSpaceToView(self, 20)
    .heightIs(16);
    
    self.address_LAB.sd_layout
    .topSpaceToView(self.name_LAB, 17)
    .leftEqualToView(self.name_LAB)
    .rightSpaceToView(self, 20)
    .heightIs(15);
}
- (void)configaddAddress {
    [self removeAllSubviews];
    [self addSubview:self.addAddressbtn];
}
#pragma mark 存取方法



- (UILabel *)name_LAB {
    if (!_name_LAB) {
        _name_LAB = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@"name"
                                                    AndFontSize:15
                                                  AndTitleColor:Col_333
                                                  Numberoflines:0
                                                  TextAlignment:NSTextAlignmentLeft
                                       adjustesFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                  conrenrRadius:0
                                         userInteractionEnabled:NO
                                                     LabelBlock:nil
                                                     lineIsShow:NO
                                                      lineFrame:CGRectZero];
    }
    return _name_LAB;
}

- (UILabel *)address_LAB {
    if (!_address_LAB) {
        _address_LAB = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@"name"
                                                    AndFontSize:13
                                                  AndTitleColor:Col_666
                                                  Numberoflines:0
                                                  TextAlignment:NSTextAlignmentLeft
                                       adjustesFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                  conrenrRadius:0
                                         userInteractionEnabled:NO
                                                     LabelBlock:nil
                                                     lineIsShow:NO
                                                      lineFrame:CGRectZero];
    }
    return _address_LAB;
}

- (UILabel *)phone_LAB {
    if (!_phone_LAB) {
        _phone_LAB = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@"name"
                                                    AndFontSize:15
                                                  AndTitleColor:Col_333
                                                  Numberoflines:0
                                                  TextAlignment:NSTextAlignmentRight
                                       adjustesFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                  conrenrRadius:0
                                         userInteractionEnabled:NO
                                                     LabelBlock:nil
                                                     lineIsShow:NO
                                                      lineFrame:CGRectZero];
    }
    return _phone_LAB;
}



- (UIButton *)addAddressbtn {
    if (!_addAddressbtn) {
        _addAddressbtn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake((KScreenWidth - 156) / 2, 15, 156, 40)
                                                               taeget:self
                                                                  sel:@selector(tap_addAddress)
                                                                  tag:0
                                                             AntTitle:nil
                                                            titleFont:0
                                                           titleColor:nil andImage:@"tianjiadizhi" AndBackColor:nil
                                              adjustsFontSizesTowidth:NO
                                                        masksToBounds:NO
                                                         conrenRadius:0
                                                          BorderColor:nil
                                                          BorderWidth:0
                                            ContentHorizontalAligment:0];
    }
    return _addAddressbtn;
  
}
@end
