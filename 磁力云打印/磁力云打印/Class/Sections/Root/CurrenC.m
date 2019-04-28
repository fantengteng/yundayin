//
//  CurrenC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/19.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "CurrenC.h"

@interface CurrenC ()

@end

@implementation CurrenC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Is_hideJuhuazhuan = NO;
   
}

- (void)initSubViewS {
    [super initSubViewS];
    self.Web.wkweb_url = self.web_url;
    [self.Web loadRefare];
}

- (void)changeDefaultConfiguration {
    self.Web_configName = @"JsUseOc";
    self.Web.wkweb_pv.ColosArray = [NSArray arrayWithObjects:(id)Col_04D.CGColor,(id)Col_04D.CGColor ,(id)Col_04D.CGColor ,nil ];
}


@end
