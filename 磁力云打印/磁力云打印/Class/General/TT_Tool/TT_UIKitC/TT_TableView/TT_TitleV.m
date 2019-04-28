//
//  PZ_TitleV.m
//  破竹
//
//  Created by 米宅 on 2018/1/24.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "TT_TitleV.h"
#import "TT_ControlTool.h"
@interface TT_TitleV ()

@property (nonatomic , strong) UILabel *titleLable;

@end


@implementation TT_TitleV

#pragma mark ---- 生命周期

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateUI];
    }
    return self;
}

#pragma mark ---- 回调协议


#pragma mark ---- 公开方法

#pragma mark ---- 私有方法


/**
 功能
 */
- (void)CreateUI {
    [self addSubview:self.titleLable];
    [self addSubview:self.ImageLayer];
}



/**
 点击按钮
 */
- (void)Btn {
    if (self.SearchClick) {
        self.SearchClick();
    }
}


#pragma mark ---- 存取方法


- (void)setTitle:(NSString *)title {
    self.titleLable.text = title;
}

- (void)setImageName:(NSString *)ImageName {
    [self.ImageLayer setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [TT_ControlTool FTT_ControlToolUILabelFrame:CGRectMake(20, 0, KScreenWidth - 80, 52)
                                                         AndTitle:@""
                                                      AndFontSize:30
                                                    AndTitleColor:[UIColor blackColor]
                                                    Numberoflines:0
                                                    TextAlignment:NSTextAlignmentCenter
                                         adjustesFontSizesTowidth:NO
                                                    masksToBounds:NO
                                                    conrenrRadius:0
                                           userInteractionEnabled:NO
                                                       LabelBlock:nil
                                                       lineIsShow:NO
                                                        lineFrame:CGRectZero];
    }
    return _titleLable;
}

- (UIButton *)ImageLayer {
    if (!_ImageLayer) {
        _ImageLayer = [TT_ControlTool FTT_ControlToolUIButtonFrame:CGRectMake(KScreenWidth - 50, 6, 40, 40)
                                                            taeget:self
                                                               sel:@selector(Btn)
                                                               tag:0
                                                          AntTitle:nil
                                                         titleFont:0
                                                        titleColor:nil
                                                          andImage:nil
                                                      AndBackColor:nil
                                           adjustsFontSizesTowidth:NO
                                                     masksToBounds:NO
                                                      conrenRadius:0
                                                       BorderColor:nil
                                                       BorderWidth:0
                                         ContentHorizontalAligment:0];
        
    
    }
    return _ImageLayer;
}

@end
