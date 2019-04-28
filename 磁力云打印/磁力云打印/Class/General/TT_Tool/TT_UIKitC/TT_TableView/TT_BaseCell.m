//
//  TT_BaseCell.m
//  破竹
//
//  Created by linlin dang on 2018/8/23.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "TT_BaseCell.h"

@implementation TT_BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


#pragma mark 生命周期

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviewS];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview CellClass:(Class)cellClass {
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    TT_BaseCell* cell = (TT_BaseCell*)[tableview dequeueReusableCellWithIdentifier:className];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    return cell;
}

#pragma mark 触发方法

#pragma mark 公开方法

- (void)configData:(id)Data {
    
}

- (void)setupSubviewS {
    
}

- (void)setupSubViewsFrame {
    
}


#pragma mark 私有方法

@end
