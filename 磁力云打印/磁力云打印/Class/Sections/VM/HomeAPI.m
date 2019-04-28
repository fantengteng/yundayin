//
//  HomeAPI.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeAPI.h"

@implementation HomeAPI


- (void)configrequestMark:(NSString *)requestMark {
    NSString *Url;
    self.Is_Cache = YES;
    self.requestType = FTT_APIManagerRequestTypePOST;
    if ([requestMark isEqualToString:RegistMARK]) {
        Url = RegistMARK;
    }else if ([requestMark isEqualToString:LoginMARK]) {
        Url = LoginMARK;
    }else if ([requestMark isEqualToString:listReceiverMARK]) {
        Url = listReceiverMARK;
    }else if ([requestMark isEqualToString:SaveReceiverMARK]) {
        Url = SaveReceiverMARK;
    }else if ([listSubDistrictMARK isEqualToString:requestMark]) {
        Url = listSubDistrictMARK;
    }else if ([requestMark isEqualToString:deleteReceiverMARK]) {
        Url = deleteReceiverMARK;
    }else if ([requestMark isEqualToString:setDefaultReceiverMARK]) {
        Url = setDefaultReceiverMARK;
    }else if ([requestMark isEqualToString:getDefAddressMARK]) {
        Url = getDefAddressMARK;
    }else if ([requestMark isEqualToString:InitMARK]) {
        Url = InitMARK;
    }else if ([requestMark isEqualToString:getURLMARK]) {
        Url = getURLMARK;
    }else if ([requestMark isEqualToString:frontApigetAboutUsMARK]) {
        self.requestUrl =  @"http://www.27305.com/frontApi/getAboutUs";
        self.requestMark = frontApigetAboutUsMARK;
        return;
    }
    self.requestUrl  = [NSString stringWithFormat:@"%@%@",PZ_Header,Url];
    self.requestMark = requestMark;
}
@end
