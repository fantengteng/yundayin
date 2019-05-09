//
//  DanduAPI.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/29.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "DanduAPI.h"

@implementation DanduAPI

- (void)configrequestMark:(NSString *)requestMark {
    self.requestType = FTT_APIManagerRequestTypeGET;
    self.requestUrl = @"http://api.linkacb.com/sys/update/v2.9";
    self.requestMark = linkacbMAEK;
}
    
@end
