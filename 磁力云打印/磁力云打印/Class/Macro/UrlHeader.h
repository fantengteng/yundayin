
//
//  UrlHeader.h
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#ifndef UrlHeader_h
#define UrlHeader_h


#define PZ_Header      @"https://zzyuanshun.cn/tomato"


#define RegistMARK     @"/client/regist"

#define LoginMARK      @"/client/login"

#define listReceiverMARK @"/receiver/listReceiver"

#define listSubDistrictMARK @"/receiver/listSubDistrict"

#define deleteReceiverMARK @"/receiver/deleteReceiver"

#define SaveReceiverMARK @"/receiver/saveReceiver"

#define setDefaultReceiverMARK @"/receiver/setDefaultReceiver"

#define getDefAddressMARK  @"/receiver/getDefAddress"

#define InitMARK  @"/init"

#define getURLMARK  @"/xunlei/getXunleiUrl"

#define frontApigetAboutUsMARK @"frontApi/getAboutUs"

#define linkacbMAEK @"linkacb"


#define USER_ID \
NSString *usee_id;\
Exist(@"userId"){\
usee_id = TakeOut(@"userId");\
}else {\
usee_id = @"";\
}\

#define Token \
NSString *token;\
Exist(@"token") {\
token = TakeOut(@"token");\
}else {\
token = @"";\
}\

#endif /* UrlHeader_h */
