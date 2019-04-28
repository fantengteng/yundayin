//
//  TT_CollectionIMGCell.m
//  TT_CollectionIMGV
//
//  Created by linlin dang on 2019/4/2.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_CollectionIMGCell.h"

@implementation TT_CollectionIMGCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self tt_setupSubViewS];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.deleteBtn.frame = CGRectMake(self.bounds.size.width - 24, 0, 24, 24);
}

- (void)tt_setupSubViewS {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.deleteBtn];
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.00 alpha:0.5];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}
@end
