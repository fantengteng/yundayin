//
//  yunfeiV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/19.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "yunfeiV.h"

@implementation yunfeiV

- (void)tt_setupViews {
    self.backgroundColor = Col_FFF;
    [self addSubview:self.name_LAB];
    [self addSubview:self.phone_LAB];
    [self addSubview:self.address_LAB];
    [self addSubview:self.line_LAB];
    [self tt_setupViewsFrame];
}

- (void)tt_setupViewsFrame {
    self.name_LAB.sd_layout
    .leftSpaceToView(self, 20)
    .widthIs(100)
    .topEqualToView(self)
    .heightIs(44);
    
    self.address_LAB.sd_layout
    .rightSpaceToView(self, 20)
    .topEqualToView(self)
    .heightIs(44)
    .leftSpaceToView(self.name_LAB, 0);
    
    self.line_LAB.sd_layout
    .topSpaceToView(self.name_LAB, 0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(1);
    
    self.phone_LAB.sd_layout
    .leftEqualToView(self)
    .rightSpaceToView(self, 20)
    .topSpaceToView(self.line_LAB, 0)
    .heightIs(73);
    
   
 
}

- (UILabel *)name_LAB {
    if (!_name_LAB) {
        _name_LAB = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@"快递费"
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
                                                          AndTitle:@"¥8.00"
                                                       AndFontSize:12
                                                     AndTitleColor:Col_666
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
    return _address_LAB;
}

- (UILabel *)line_LAB {
    if (!_line_LAB) {
        _line_LAB = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@""
                                                    AndFontSize:0
                                                  AndTitleColor:nil
                                                  Numberoflines:0
                                                  TextAlignment:NSTextAlignmentCenter
                                       adjustesFontSizesTowidth:NO
                                                  masksToBounds:NO
                                                  conrenrRadius:0
                                         userInteractionEnabled:NO
                                                     LabelBlock:nil
                                                     lineIsShow:NO
                                                      lineFrame:CGRectZero];
        _line_LAB.backgroundColor = Col_ECE;
    }
    return _line_LAB;
}

- (UILabel *)phone_LAB {
    if (!_phone_LAB) {
        _phone_LAB = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                        AndTitle:@"name"
                                                     AndFontSize:15
                                                   AndTitleColor:Col_FF3
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



@end
