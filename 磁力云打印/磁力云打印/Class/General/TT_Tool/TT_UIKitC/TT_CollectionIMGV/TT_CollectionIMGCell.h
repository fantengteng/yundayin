//
//  TT_CollectionIMGCell.h
//  TT_CollectionIMGV
//
//  Created by linlin dang on 2019/4/2.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TT_CollectionIMGCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic , copy) void(^currencyparameterClose) (NSInteger type, id Data);
@end

NS_ASSUME_NONNULL_END
