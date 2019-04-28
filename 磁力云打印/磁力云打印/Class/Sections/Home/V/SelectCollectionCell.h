//
//  SelectCollectionCell.h
//  磁力云打印
//
//  Created by linlin dang on 2019/4/22.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_CollectionIMGCell.h"
#import "HomeSelectIMGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IMG;
@property (weak, nonatomic) IBOutlet UIButton *jian_Btn;
@property (weak, nonatomic) IBOutlet UILabel *num_lab;
@property (weak, nonatomic) IBOutlet UIButton *jia_Btn;
@property (nonatomic , strong) HomeSelectIMGModel *model;
@property (nonatomic , copy) void(^currencyparameterClose) (NSInteger type, id Data);
@property (nonatomic , assign) NSInteger num;

@end

NS_ASSUME_NONNULL_END
