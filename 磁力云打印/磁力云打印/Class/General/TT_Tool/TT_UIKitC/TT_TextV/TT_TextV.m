//
//  TT_TextV.m
//  TextView
//
//  Created by linlin dang on 2018/12/5.
//  Copyright © 2018 FTT. All rights reserved.
//

#import "TT_TextV.h"
#import "TT_TextView.h"
@interface TT_TextV ()<TT_TextViewDelegate>
@property (nonatomic , strong) TT_TextView *textview;
@property (nonatomic , assign) CGFloat keyboardY;
@property (nonatomic , assign) CGFloat tt_bgH;
@end


@implementation TT_TextV


#pragma mark 生命周期

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviewS];
        [self registerKeyBoardNotification];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviewS];
        [self registerKeyBoardNotification];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 回调协议

- (void)gettextViewH:(CGFloat)textViewH {
    self.tt_bgH          = textViewH + 12;
    self.tt_bgview.frame = CGRectMake(0, self.keyboardY - textViewH  - 12, self.bounds.size.width , textViewH + 12);
    self.textview.frame  = CGRectMake(20, 6, self.tt_bgview.bounds.size.width - 80, textViewH);
    self.send_btn.frame  = CGRectMake(self.tt_bgview.bounds.size.width - 80, self.tt_bgview.bounds.size.height - 50, 80, 50);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark 触发方法

/// 键盘起来
- (void)handleKeyBoardHide:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardY = rect.origin.y;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.tt_bgview.frame = CGRectMake(0, rect.origin.y - self.tt_bgH, self.bounds.size.width, self.tt_bgH);
        self.send_btn.frame  = CGRectMake(self.tt_bgview.bounds.size.width - 80, self.tt_bgview.bounds.size.height - 50, 80, 50);
    }];
}

/// 键盘消失
- (void)handleKeyBoardAction:(NSNotification *)noti {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}


- (void)send {
    if (self.textview.text.length != 0 || ![self.textview.text isEqualToString:self.placeholdstr]) {
        [self endEditing:YES];
        if (self.TT_deldgate && [self.TT_deldgate respondsToSelector:@selector(TT_TextVtapSendTriggereventWithtext:)]) {
            [self.TT_deldgate TT_TextVtapSendTriggereventWithtext:self.textview.text];
        }
    }
}

#pragma mark 公开方法

/// 对外公开界面显示
- (void)Keyboardbounceshow {
    [self.textview becomeFirstResponder];
}

/// 对外公开界面消失
- (void)Keyboardbouncedishide {
    [self.textview resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self.textview showplaceholdtext];
        self.tt_bgH = 50;
    }];
}
#pragma mark 私有方法

/**
 注册监听键盘
 */
- (void)registerKeyBoardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardAction:) name:UIKeyboardWillHideNotification object:nil];
}

/// 添加视图
- (void)initSubviewS {
    self.tt_bgH = 50;
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [self addSubview:self.tt_bgview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self.tt_bgview addSubview:self.textview];
    [self.tt_bgview addSubview:self.send_btn];
}


#pragma mark 存取方法

- (void)setBtn_str:(NSString *)btn_str {
    [self.send_btn setTitle:btn_str forState:UIControlStateNormal];
}

- (void)setBtn_color:(UIColor *)btn_color {
    [self.send_btn setTitleColor:btn_color forState:UIControlStateNormal];
}
- (TT_TextView *)textview {
    if (!_textview) {
        _textview = [[TT_TextView alloc]initWithFrame:CGRectMake(20, 6, self.tt_bgview.bounds.size.width - 80, 38)];
        _textview.font = [UIFont systemFontOfSize:18];
        _textview.tt_Delegate = self;
    }
    return _textview;
}

- (void)setPlaceholdstr:(NSString *)placeholdstr {
    _placeholdstr = placeholdstr;
    self.textview.tt_placeholder = placeholdstr;
}

- (UIView *)tt_bgview {
    if (!_tt_bgview) {
        _tt_bgview = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.tt_bgH)];
        _tt_bgview.backgroundColor = [UIColor whiteColor];
    }
    return _tt_bgview;
}

- (UIButton *)send_btn {
    if (!_send_btn) {
        _send_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _send_btn.frame = CGRectMake(self.tt_bgview.bounds.size.width - 80 , self.tt_bgview.bounds.size.height - 50, 80, 50);
        [_send_btn setTitle:@"提交" forState:UIControlStateNormal];
        [_send_btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_send_btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    }
    return _send_btn;
}


@end
