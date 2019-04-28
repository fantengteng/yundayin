//
//  HomeVM.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeVM.h"
#import "MyaddressModel.h"
@implementation HomeVM



- (void)dataConversion:(FTT_APIBaseManager *)Manager {
    if ([Manager.requestMark isEqualToString:RegistMARK]) {
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:LoginMARK]) {
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:listReceiverMARK]) {
        [self listRecivermethod:Manager];
    }else if ([Manager.requestMark isEqualToString:SaveReceiverMARK]) {
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:deleteReceiverMARK]) {
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:setDefaultReceiverMARK]) {
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:getDefAddressMARK]) {
        [self getDefAddressmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:InitMARK]) {
        SaveObject(Manager.responseObject[@"info"], @"V")
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:getURLMARK]) {
        SaveObject(Manager.responseObject[@"info"], @"GUR")
        [self ElasticGeneralmethod:Manager];
    }else if ([Manager.requestMark isEqualToString:frontApigetAboutUsMARK]) {
        [self frontApigetAboutModeltransformation:Manager];
    }
}

- (void)frontApigetAboutModeltransformation:(FTT_APIBaseManager *)Manager  {
    NSDictionary *dic = Manager.responseObject;
    TT_Log(@"%@",dic);
    SaveObject(dic, @"INFO")
    if (self.New_Close) {
        self.New_Close(Manager.responseObject, nil, YES, NO, Manager.requestMark);
    }
}

- (void)listRecivermethod:(FTT_APIBaseManager *)Manager {
    NSMutableArray *data = [MyaddressModel mj_objectArrayWithKeyValuesArray:Manager.responseObject[@"info"]];
    if (self.New_Close) {
        self.New_Close(Manager.responseObject, data, YES, NO, Manager.requestMark);
    }
}

- (void)getDefAddressmethod:(FTT_APIBaseManager *)Manager {
    NSMutableArray *data = [NSMutableArray new];
    if ([Manager.responseObject[@"info"]  isKindOfClass:[NSDictionary class]]) {
        MyaddressModel *model = [MyaddressModel mj_objectWithKeyValues:Manager.responseObject[@"info"]];
        [data addObject:model];
    }
    
    if (self.New_Close) {
        self.New_Close(Manager.responseObject, data, YES, NO, Manager.requestMark);
    }
}

- (void)ElasticGeneralmethod:(FTT_APIBaseManager *)Manager {
    if (self.New_Close) {
        self.New_Close(Manager.responseObject, nil, YES, NO, Manager.requestMark);
    }
}









@end
