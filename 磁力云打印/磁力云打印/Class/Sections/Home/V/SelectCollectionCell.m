//
//  SelectCollectionCell.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/22.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "SelectCollectionCell.h"

@implementation SelectCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.num = 1;
 
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SelectCollectionCell" owner:self options:nil].lastObject;
    }
    return self;
}
- (IBAction)jia:(id)sender {
    self.num++;
    self.model.num = self.num;
}
- (IBAction)jian:(id)sender {
    if (self.num == 1) {
        if (self.currencyparameterClose) {
            self.currencyparameterClose(-1, @"");
        }
    }else {
        self.num--;
        self.model.num = self.num;
    }
}

- (void)setNum:(NSInteger)num {
    _num = num;
    self.num_lab.text = [NSString stringWithFormat:@"%ld",(long)self.num];
}

- (void)setModel:(HomeSelectIMGModel *)model {
    _model = model;
    model.num = 1;
    self.IMG.image = model.IMG;
}
@end
