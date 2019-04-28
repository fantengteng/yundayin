//
//  FTT_APIBaseManager.m
//  95128
//
//  Created by 樊腾 on 17/6/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "FTT_APIBaseManager.h"
#import "PZ_CacheTool.h"
#ifdef DEBUG
#define FTT_Log(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define FTT_Log(...)
#endif


NSString *const HttpCaChe = @"HttpRequestCaChe";

@interface FTT_APIBaseManager ()

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) FTT_APIManagerErrorType errorType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSURLSessionTask *task;

@end



@implementation FTT_APIBaseManager


- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = nil;
        self.DataSource = nil;
        self.task = nil;
        self.params = nil;
        self.Is_Cache = YES;
        self.errorType = FTT_APIManagerErrorTypeDefault;
        self.responseObject = nil;
    }
    return self;
}


- (void)loadData {
    if (self.DataSource) {
        if ([self.DataSource respondsToSelector:@selector(paramsForApi:)]) {
            self.params = [self.DataSource paramsForApi:self];
        }
    }else {
        self.params = nil;
    }
    
    YYCache *cache = [PZ_CacheTool CreateNetWorkCacheName:HttpCaChe];

    NSDate *now = [NSDate new];
    NSString *lastTime = TakeOut(@"lastT");
    NSString *lastR = TakeOut(@"lastR");
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *last = [dateFormatter dateFromString:lastTime];
    NSTimeInterval delta = now.timeIntervalSince1970 - last.timeIntervalSince1970;
    NSString *CacheStr = [NSString stringWithFormat:@"%@%@",self.requestMark,self.params];
    if (![YYReachability reachability].isReachable) {
        id cacheData = [cache objectForKey:CacheStr];
        if (cacheData != nil) {
            self.errorType = FTT_APIManagerErrorTypeCache;
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                self.responseObject =[NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableLeaves error:nil];
                [self.delegate managerCallAPIDidSuccess:self];
                self.task = nil;
            }
            return;
        }else {
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                [self.delegate managerCallAPIDidFailed:self];
                self.task = nil;
            }
        }
    }else if ([lastR isEqualToString:CacheStr] && (int)delta < 10) {
        id cacheData = [cache objectForKey:CacheStr];
        if (cacheData != nil) {
            self.errorType = FTT_APIManagerErrorTypeSuccess;
            if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                self.responseObject =[NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableLeaves error:nil];
                [self.delegate managerCallAPIDidSuccess:self];
                self.task = nil;
            }
            return;
        }
    }
    SaveValue(CacheStr, @"lastR")
    SaveValue([FTT_Helper loadNewTime:@"yyyyMMddHHmmss"], @"lastT")
    __weak typeof(self)weakself = self;
    self.task = [[FTT_NetWorkkingManager shareManager]callApiWithUrl:self.requestUrl params:self.params?:@{} requestType:self.requestType success:^(id responseObject, FTT_APIManagerErrorType errorType) {
        TT_Log(@"-------%@---------%@",weakself.requestMark,responseObject);
        if (weakself.delegate) {
            if (errorType == FTT_APIManagerErrorTypeSuccess) {
                weakself.errorType = FTT_APIManagerErrorTypeSuccess;
                if ([weakself.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
                    weakself.responseObject = responseObject;
                    if (self.Is_Cache) {
                        [weakself initCache:responseObject cache:cache cacheKey:CacheStr];
                    }
                    [weakself.delegate managerCallAPIDidSuccess:weakself];
                    weakself.task = nil;
                }
            }else {
                weakself.errorType = errorType;
                if ([weakself.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                    [weakself.delegate managerCallAPIDidFailed:weakself];
                    weakself.task = nil;
                }
            }
        }
    } fail:^(id responseObject, FTT_APIManagerErrorType errorType) {
        weakself.errorType = errorType;
        TT_Log(@"%@",responseObject);

        switch (weakself.errorType) {
            case FTT_APIManagerErrorTypeNoNetWork:
                weakself.errorMessage = NSLocalizedString(@"APIManagerErrorTypeNoNetwork", nil);
                break;

            case FTT_APIManagerErrorTypeDefault:
                weakself.errorMessage = NSLocalizedString(@"APIManagerErrorTypeDefault", nil);
                break;

            case FTT_APIManagerErrorTypeTimeout:
                weakself.errorMessage = NSLocalizedString(@"APIManagerErrorTypeTimeout", nil);
                break;

            default:
                weakself.errorMessage = @"";
                break;
        }
        if (weakself.delegate) {
            if ([weakself.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
                [weakself.delegate managerCallAPIDidFailed:weakself];
                weakself.task = nil;
            }
        }
    }];
}

- (void)LoadCache:(FTT_APIManagerErrorType)type cache:(YYCache*)cache{
    id cacheData = [cache objectForKey:self.requestMark];
    if (cacheData != nil) {
        self.errorType = type;
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
            self.responseObject =[NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableLeaves error:nil];
            [self.delegate managerCallAPIDidSuccess:self];
            self.task = nil;
        }
        SaveValue(self.requestMark, @"lastR");
        SaveValue([FTT_Helper loadNewTime:@"yyyyMMddHHmmss"], @"lastT")
    }
}
/*
 功能：存本地
 备注：无
 */
- (void)initCache:(id)responseObject cache:(YYCache*)cache cacheKey:(NSString *)cacheKey{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    NSData *data= [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    dataString = [self deleteSpecialCodeWithStr:dataString];
    NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [cache setObject:requestData forKey:cacheKey];
}

- (void)configrequestMark:(NSString *)requestMark {
    
}
#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}


- (void)dealloc {
    [self cancelAllRequest];
}


- (void)cancelAllRequest {
    if (self.task) {
        [self.task cancel];
        self.task = nil;
    }
}


@end
