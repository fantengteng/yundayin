//
//  TT_NothingV.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/15.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_NothingV.h"


@interface TT_NothingV ()


@end

@implementation TT_NothingV




#pragma mark 生命周期

#pragma mark 回调协议

#pragma mark 触发方法

- (void)Tap {
    if (self.ViewtapClose) {
        self.ViewtapClose(0, self.textLayer.string);
    }
}

#pragma mark 公开方法

- (void)tt_setupViews {
    [self.layer addSublayer:self.ImageLayer];
    [self.layer addSublayer:self.textLayer];
    [self tt_setupViewsFrame];
}

- (void)tt_setupViewsFrame {
    self.ImageLayer.frame = CGRectMake(self.V_screnW / 2 - 43.5 , self.V_screnH / 2 - 72, 87, 100);
    self.textLayer.frame  = CGRectMake(0, CGRectGetMaxY(self.ImageLayer.frame) + 20, self.V_screnW, 18);
}



- (void)configImageName:(NSString *)ImaageName titleName:(NSString *)titleName is_Tap:(BOOL)is_Tap{
    self.ImageLayer.contents = (__bridge id)[UIImage imageNamed:ImaageName].CGImage;
    self.textLayer.string    = titleName;
    if (is_Tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap)];
        [self addGestureRecognizer:tap];
    }
}
#pragma mark 私有方法

#pragma mark 存取方法

- (CALayer *)ImageLayer {
    if (!_ImageLayer) {
        _ImageLayer = [TT_ControlTool FTT_ControlToolCALayerFrame:CGRectZero
                                                     AndImageName:@"kong"
                                               AndBackgtoundColor:nil
                                                      BorderColor:nil
                                                      BorderWidth:0
                                                    masksToBounds:NO
                                                      corerRadius:0];
    }
    return _ImageLayer;
    
}


- (CATextLayer *)textLayer {
    if (!_textLayer) {
        _textLayer = [TT_ControlTool FTT_ControlToolCATextLayerFrame:CGRectZero
                                                            AndTitle:@"空空如也"
                                                         AndFontSize:14
                                                  AndForegroundColor:[UIColor getColor:@"#666666"]
                                                   AndTruncationMode:kCATruncationEnd];
        _textLayer.alignmentMode = kCAAlignmentCenter;
    }
    return _textLayer;
}



@end
