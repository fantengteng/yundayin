//
//  MyaddressModel.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyaddressModel : NSObject

@property (nonatomic , copy) NSString *userId;
@property (nonatomic , copy) NSString *receiverId;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *phone;
@property (nonatomic , copy) NSString *address;
@property (nonatomic , copy) NSString *provinceId;
@property (nonatomic , copy) NSString *cityId;
@property (nonatomic , copy) NSString *districtId;
@property (nonatomic , assign) NSInteger isDefault;
@property (nonatomic , copy) NSString *aliAccount;
@property (nonatomic , copy) NSString *postCode;
@property (nonatomic , copy) NSString *addTime;

@property (nonatomic , copy) NSString *provinceName;
@property (nonatomic , copy) NSString *cityName;
@property (nonatomic , copy) NSString *districtName;
@property (nonatomic , copy) NSString *detailAddress;

@end

NS_ASSUME_NONNULL_END
