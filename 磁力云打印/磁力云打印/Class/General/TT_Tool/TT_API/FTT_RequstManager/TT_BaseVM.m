//
//  PZ_BaseVM.m
//  破竹
//
//  Created by linlin dang on 2018/9/5.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "TT_BaseVM.h"

@interface TT_BaseVM ()

@property (nonatomic , strong) NSMutableArray *NetworkArray;

@property (nonatomic , strong) NSMutableArray *NetworkClassArray;

@end

@implementation TT_BaseVM


+ (instancetype)setupVMclass:(Class)VMclass {
    return [[VMclass alloc]init];
}


- (void)testloadDataResuletBlock:(void (^)(NSMutableArray *, BOOL, BOOL))resulteBlock {
    resulteBlock([self configtextData],YES,YES);
}

- (NSMutableArray *)configtextData {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < 10 ; i++) {
        [arr addObject:@"TT"];
    }
    return arr;
}

- (void)loadDataNetWorkWithAnswersParams:(NSMutableDictionary *)Params
                             networkName:(NSString *)networkName
                            networkClass:(Class)networkClass
                            ResuletBlcok:(void(^)(id allData ,NSMutableArray *Data , BOOL SucessORfail , BOOL has_more , NSString *mark))resulteBlock {
    self.DIC = Params;
    self.New_Close = resulteBlock;
    FTT_APIBaseManager *API;
    if (![self.NetworkClassArray containsObject:networkName]) {
        API = [[networkClass alloc]init];
        [self.NetworkClassArray addObject:networkName];
        [self.NetworkArray addObject:API];
    }else {
        NSInteger index = [self.NetworkClassArray indexOfObject:networkName];
        API = self.NetworkArray[index];
    }
    [API configrequestMark:networkName];
    API.DataSource = self;
    API.delegate   = self;
    [API loadData];
}

- (void)configNetwork:(NSString *)networkName {
    [self.API_manager configrequestMark:networkName];
     self.API_manager.DataSource = self;
     self.API_manager.delegate   = self;
    [self.API_manager loadData];
}

- (void)managerCallAPIDidFailed:(FTT_APIBaseManager *)Manager {
    if (self.New_Close) {
        self.New_Close(nil, nil, NO, NO, Manager.requestMark);
    }
}
- (void)managerCallAPIDidSuccess:(FTT_APIBaseManager *)Manager {
    if ([Manager.responseObject[@"status"] integerValue] == 1) {
        [self dataConversion:Manager];
    }else {
        if (self.New_Close) {
            self.New_Close(nil, nil, NO, NO, Manager.requestMark);;
        }
    }
}

- (NSDictionary *)paramsForApi:(FTT_APIBaseManager *)Manager {
    return self.DIC;
}

- (void)dataConversion:(FTT_APIBaseManager *)Manager {
    
}

- (NSMutableDictionary *)DIC {
    if (!_DIC) {
        _DIC = [NSMutableDictionary new];
    }
    return _DIC;
}

- (NSMutableArray *)NetworkArray {
    if (!_NetworkArray) {
        _NetworkArray = [NSMutableArray new];
    }
    return _NetworkArray;
}

- (NSMutableArray *)NetworkClassArray {
    if (!_NetworkClassArray) {
        _NetworkClassArray = [NSMutableArray new];
    }
    return _NetworkClassArray;
}
@end
