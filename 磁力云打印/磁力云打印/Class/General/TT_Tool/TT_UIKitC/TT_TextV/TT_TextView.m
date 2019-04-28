//
//  TT_TextView.m
//  TextView
//
//  Created by linlin dang on 2018/12/5.
//  Copyright © 2018 FTT. All rights reserved.
//

#import "TT_TextView.h"

@interface TT_TextView ()

/// UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
@property (nonatomic, strong) UITextView *placeholderView;
///文字高度
@property (nonatomic, assign) NSInteger textH;
/// 文字最大高度
@property (nonatomic, assign) NSInteger maxTextH;


@end

@implementation TT_TextView


#pragma mark 生命周期

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tt_textViewfirstH = frame.size.height;
        [self initSubViews];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(text))];
}


#pragma mark 回调协议


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(text))]) {
        // 根据文字内容决定placeholderView是否隐藏
        self.placeholderView.hidden = self.text.length > 0;
    }
}


- (void)textDidChange{
    // 根据文字内容决定placeholderView是否隐藏
    self.placeholderView.hidden = self.text.length > 0;
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    if (_textH != height ) { // 高度不一样，就改变了高度
        // 当高度大于最大高度时，需要滚动
        self.scrollEnabled = height > _maxTextH && _maxTextH > 0;
        height = height > self.tt_textViewfirstH ? height : self.tt_textViewfirstH;
        _textH = height;
     
        //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
        if (self.tt_Delegate && self.scrollEnabled == NO && [self.tt_Delegate respondsToSelector:@selector(gettextViewH:)]) {
            [self.tt_Delegate gettextViewH:height];
        }
        [self.superview layoutIfNeeded];
        self.placeholderView.frame = self.bounds;
    }
}

#pragma mark 触发方法

#pragma mark 公开方法

- (void)showplaceholdtext {
    self.text = @"";
    self.placeholderView.hidden = NO;
}

#pragma mark 私有方法

- (void)initSubViews {
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.tt_placeholder = @"请输入此时此刻的想法";
    self.tt_placeholderFont = [UIFont systemFontOfSize:16];
    self.tt_placeholderColor = [UIColor grayColor];
    ///实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
    ///设置监听，监听对text的赋值操作情况的处理
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(text)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
}

#pragma mark 存取方法


- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines {
    _maxNumberOfLines = maxNumberOfLines;
    
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
}

- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setTt_placeholderColor:(UIColor *)tt_placeholderColor {
    _tt_placeholderColor = tt_placeholderColor;
    self.placeholderView.textColor = tt_placeholderColor;
}

- (void)setTt_placeholder:(NSString *)tt_placeholder {
    _tt_placeholder = tt_placeholder;
    self.placeholderView.text = tt_placeholder;
}

- (void)setTt_placeholderFont:(UIFont *)tt_placeholderFont {
    _tt_placeholderFont = tt_placeholderFont;
    self.placeholderView.font = tt_placeholderFont;
}

- (UITextView *)placeholderView
{
    if (!_placeholderView ) {
        _placeholderView  = [[UITextView alloc] initWithFrame:self.bounds];
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font =  self.font;
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:_placeholderView];
    }
    return _placeholderView;
}


@end
