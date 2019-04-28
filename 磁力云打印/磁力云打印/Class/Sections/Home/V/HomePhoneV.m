//
//  HomePhoneV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/18.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomePhoneV.h"
#import "TT_CollectionIMGV.h"
#import "HomeSelectIMGModel.h"
@interface HomePhoneV ()

@property (nonatomic , strong) UILabel *name_LAB;
@property (nonatomic , strong) UILabel *phone_LAB;
@property (nonatomic , strong) UILabel *line_LAB;
@property (nonatomic , strong) TT_CollectionIMGV *IMGV;
@end

@implementation HomePhoneV


#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法

- (void)chufafangfa:(CGFloat)H {
    if (self.ViewtapClose) {
        self.ViewtapClose(H + 50, @"");
    }
    
}

#pragma mark 公开方法

- (void)tt_setupViews{
    [self addSubview:self.name_LAB];
    [self addSubview:self.phone_LAB];
    [self addSubview:self.line_LAB];
    [self addSubview:self.IMGV];
    [self tt_setupViewsFrame];
    self.backgroundColor = Col_FFF;
    [self tt_configClose];
    
}

- (void)tt_setupViewsFrame {
    self.name_LAB.sd_layout
    .leftSpaceToView(self, 20)
    .widthIs(100)
    .topEqualToView(self)
    .heightIs(44);
    
    self.phone_LAB.sd_layout
    .rightSpaceToView(self, 20)
    .topEqualToView(self)
    .heightIs(44)
    .leftSpaceToView(self.name_LAB, 0);
    
    self.line_LAB.sd_layout
    .topSpaceToView(self.name_LAB, 0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(1);
    
    self.IMGV.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(self.line_LAB, 0)
    .heightIs((KScreenWidth - 30 - 20 ) / 3  + 10 );
    
}

- (void)tt_configClose {
    @weakify(self)
    self.IMGV.ChangeFrame = ^(CGFloat H) {
        @strongify(self)
        self.IMGV.sd_layout
        .leftSpaceToView(self, 5)
        .rightSpaceToView(self, 5)
        .topSpaceToView(self.line_LAB, 0)
        .heightIs(H);
        [self chufafangfa:H];
    };
}

- (void)configIMGArr:(NSArray *)IMGArr info:(NSString *)info money:(CGFloat )money{
    self.IMGV.maxCount = IMGArr.count;
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger Num = 0;
    for (HomeSelectIMGModel *model in IMGArr) {
        [arr addObject:model.IMG];
        Num = Num + model.num;
    }
    self.IMGV.selectedPhotos = arr;
    [self.IMGV.collectionView reloadData];
    [self.IMGV changeCollectionFrame];
    self.name_LAB.text = info;
    self.phone_LAB.text = [NSString stringWithFormat:@"%ld X ¥%.2f=¥%.2f",(long)Num,money,money * Num];
    
    
}
#pragma mark 私有方法

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
- (TT_CollectionIMGV *)IMGV {
    if (!_IMGV) {
        IPhoneXHeigh
        _IMGV = [[TT_CollectionIMGV alloc]initWithFrame:CGRectMake(5, 44,  KScreenWidth - 10, security_H - 50)];
        self.IMGV.collectionView.backgroundColor = Col_FFF;
    }
    return _IMGV;
}
@end
