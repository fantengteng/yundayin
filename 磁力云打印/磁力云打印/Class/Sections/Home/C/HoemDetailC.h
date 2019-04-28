//
//  HoemDetailC.h
//  磁力云打印
//
//  Created by linlin dang on 2019/4/17.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HoemDetailC : TT_BaseC
@property (weak, nonatomic) IBOutlet UIImageView *headerIMG;
@property (weak, nonatomic) IBOutlet UILabel *title_LAB;
@property (weak, nonatomic) IBOutlet UILabel *size_LAB;
@property (weak, nonatomic) IBOutlet UILabel *price_LAB;
@property (weak, nonatomic) IBOutlet UIButton *select_phoneBTN;
@property (weak, nonatomic) IBOutlet UIView *title_BG;

@property (nonatomic , strong) NSString *header_Str;

@property (nonatomic , strong) NSString *size_Str;

@property (nonatomic , strong) NSString *mm_Str;

@property (nonatomic , assign) CGFloat money;



@end

NS_ASSUME_NONNULL_END
