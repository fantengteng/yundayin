//
//  MyAddressCell.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "MyAddressCell.h"

@implementation MyAddressCell


#pragma mark 生命周期

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark 回调协议

#pragma mark 触发方法

- (void)tap:(UIButton *)btn {
    if (self.currencyClose) {
        self.currencyClose(btn.tag);
    }
}


- (void)configBtnState:(NSInteger)YorN {
    NSString *IMAGE_Name;
    if (YorN == 0) {
        IMAGE_Name = @"weixuanzhong";
    }else {
        IMAGE_Name = @"xuanzhong";
    }
    [self.setAddress_btn setImage:[UIImage imageNamed:IMAGE_Name] forState:UIControlStateNormal];
}

#pragma mark 公开方法


- (void)configData:(MyaddressModel *)Data {
    
    self.name_lab.text = Data.name;
    self.phone_lab.text = Data.phone;
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",Data.detailAddress]];
    content.lineSpacing = 5;
    content.color       = Col_666;
    content.font        = [UIFont systemFontOfSize:12];
    self.message_lab.attributedText = content;
    CGSize maxsize = CGSizeMake(KScreenWidth - 30, MAXFLOAT);
    YYTextLayout *layout1 = [YYTextLayout layoutWithContainerSize:maxsize text:content];
    self.message_lab.sd_layout
    .heightIs(layout1.textBoundingSize.height);
    
    self.line.sd_layout
    .leftEqualToView(self.BG)
    .rightEqualToView(self.BG)
    .topSpaceToView(self.message_lab, 18)
    .heightIs(1);
    
    self.setAddress_btn.sd_layout
    .leftEqualToView(self.BG)
    .topSpaceToView(self.line, 0)
    .widthIs(120)
    .heightIs(44);
    
    self.delete_btn.sd_layout
    .rightSpaceToView(self.BG, 0)
    .topSpaceToView(self.line, 0)
    .widthIs(60)
    .heightIs(44);
    
    self.bianji_btn.sd_layout
    .rightSpaceToView(self.delete_btn, 0)
    .topSpaceToView(self.line, 0)
    .widthIs(60)
    .heightIs(44);
    
    self.BG.sd_layout
    .heightIs(49 + layout1.textBoundingSize.height + 19 + 44);
    
    [self configBtnState:Data.isDefault];
    [self setupAutoHeightWithBottomView:self.BG bottomMargin:10];
}


#pragma mark 私有方法

- (void)setupSubviewS {
    self.contentView.backgroundColor = Col_F6F;
    [self.contentView addSubview:self.BG];
    [self.BG addSubview:self.name_lab];
    [self.BG addSubview:self.phone_lab];
    [self.BG addSubview:self.message_lab];
    [self.BG addSubview:self.line];
    [self.BG addSubview:self.setAddress_btn];
    [self.BG addSubview:self.bianji_btn];
    [self.BG addSubview:self.delete_btn];
    [self setupSubViewsFrame];
}

- (void)setupSubViewsFrame {
    
    self.BG.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    
    self.name_lab.sd_layout
    .leftSpaceToView(self.BG, 15)
    .topSpaceToView(self.BG, 15)
    .heightIs(22)
    .widthIs(150);
    
    self.phone_lab.sd_layout
    .rightSpaceToView(self.BG, 15)
    .topSpaceToView(self.BG, 15)
    .widthIs(150)
    .heightIs(22);
    
    self.message_lab.sd_layout
    .leftSpaceToView(self.BG, 15)
    .rightSpaceToView(self.BG, 15)
    .topSpaceToView(self.name_lab, 12);
    
    
}

#pragma mark 存取方法

- (void)setModel:(MyaddressModel *)model {
    _model = model;
    [self configData:model];
}

- (UIView *)BG {
    if (!_BG) {
        _BG = [TT_ControlTool FTT_ControlToolUIViewFrame:CGRectZero
                                         BackgroundColor:Col_FFF
                                           MasksToBounds:NO
                                           ConrenrRadius:0];
    }
    return _BG;
}

- (UILabel *)name_lab {
    if (!_name_lab) {
        _name_lab = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                       AndTitle:@"ss"
                                                    AndFontSize:16
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
    return _name_lab;
}

- (UILabel *)phone_lab {
    if (!_phone_lab) {
        _phone_lab = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                        AndTitle:@"ss"
                                                     AndFontSize:16
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
    return _phone_lab;
}

- (UILabel *)message_lab {
    if (!_message_lab) {
        _message_lab = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                          AndTitle:@"ss"
                                                       AndFontSize:12
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
    return _message_lab;
}

- (UILabel *)line {
    if (!_line) {
        _line = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectZero
                                                   AndTitle:@""
                                                AndFontSize:12
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
        
        _line.backgroundColor = Col_ECE;
    }
    return _line;
}

- (UIButton *)delete_btn {
    if (!_delete_btn) {
        _delete_btn = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectZero
                                                            taeget:self
                                                               sel:@selector(tap:)
                                                               tag:1
                                                          AntTitle:@"删除"
                                                         titleFont:12
                                                        titleColor:Col_666
                                                          andImage:nil
                                                      AndBackColor:nil
                                           adjustsFontSizesTowidth:NO
                                                     masksToBounds:NO
                                                      conrenRadius:0
                                                       BorderColor:nil
                                                       BorderWidth:0
                                         ContentHorizontalAligment:0];
    }
    return _delete_btn;
}

- (UIButton *)bianji_btn {
    if (!_bianji_btn) {
        _bianji_btn =[TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectZero
                                                           taeget:self
                                                              sel:@selector(tap:)
                                                              tag:2
                                                         AntTitle:@"编辑"
                                                        titleFont:12
                                                       titleColor:Col_666
                                                         andImage:nil
                                                     AndBackColor:nil
                                          adjustsFontSizesTowidth:NO
                                                    masksToBounds:NO
                                                     conrenRadius:0
                                                      BorderColor:nil
                                                      BorderWidth:0
                                        ContentHorizontalAligment:0];
    }
    return _bianji_btn;
}


- (TT_Custonbtn *)setAddress_btn {
    if (!_setAddress_btn) {
        _setAddress_btn = [TT_ControlTool FTT_ControlToolFTT_CustonbtnFrame:CGRectZero
                                                                     taeget:self
                                                                        sel:@selector(tap:)
                                                                        tag:3
                                                       AndTitleAndImageType:UIButtonTitleAndImageTypeLift
                                                                  AndImageW:20
                                                                     ImageH:20
                                                                     TitleW:84
                                                                     TitleH:44
                                                                   AndImage:[UIImage imageNamed:@"Oval Copy"] title:@"设为默认地址"
                                                                 titleColor:Col_666
                                                                  BackColor:nil
                                                                   TextFont:12
                                                                BorderColor:nil
                                                                BorderWidth:0
                                                              masksToBounds:NO
                                                                corerRadius:0
                                                                        pxy:11
                                                  ContentHorizontalAligment:0];
    }
    return _setAddress_btn;
}

@end
