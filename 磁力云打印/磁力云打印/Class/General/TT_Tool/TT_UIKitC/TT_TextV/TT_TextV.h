//
//  TT_TextV.h
//  TextView
//
//  Created by linlin dang on 2018/12/5.
//  Copyright © 2018 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TT_TextVDelegate <NSObject>

- (void)TT_TextVtapSendTriggereventWithtext:(NSString *)text;

@end

@interface TT_TextV : UIView

@property (nonatomic , weak) id<TT_TextVDelegate>TT_deldgate;

@property (nonatomic , strong) NSString *placeholdstr;
/// 按钮字体颜色
@property (nonatomic , strong) UIColor *btn_color;
/// 按钮字体文字
@property (nonatomic , strong) NSString *btn_str;
/// 输入框和按钮的背景
@property (nonatomic , strong) UIView *tt_bgview;
/// 发送按钮
@property (nonatomic , strong) UIButton *send_btn;
/// 界面显示
- (void)Keyboardbounceshow ;
/// 界面消失
- (void)Keyboardbouncedishide;
@end

NS_ASSUME_NONNULL_END
