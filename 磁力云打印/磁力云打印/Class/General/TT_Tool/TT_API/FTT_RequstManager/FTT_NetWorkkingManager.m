//
//  FTT_NetWorkkingManager.m
//  95128
//
//  Created by 樊腾 on 17/6/9.
//  Copyright © 2017年 FTT. All rights reserved.
//

#import "FTT_NetWorkkingManager.h"
#import "NSDictionary+PropertyCode.h"
@interface FTT_NetWorkkingManager ()

/**
 通用会话管理器
 */
@property (nonatomic , strong) AFHTTPSessionManager *sessionManager;

@end


@implementation FTT_NetWorkkingManager

/**
 创建及获取单例对象

 @return 管理请求的单例对象
 */
+ (instancetype)shareManager {
    static FTT_NetWorkkingManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FTT_NetWorkkingManager alloc]init];
    });
    return manager;
}

/**
 初始化方法

 @return 初始化对象
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSessionManager];
    }
    return self;
}

- (void)initSessionManager {
    _sessionManager = [[AFHTTPSessionManager alloc]init];
    _sessionManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    _sessionManager.requestSerializer.timeoutInterval = 20;
    //设置响应序列化器，解析Json对象
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:  @"application/x-javascript", @"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    _sessionManager.responseSerializer = responseSerializer;
    // 设置安全策略
    self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];;

}


- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(FTT_APIManagerRequestType)requestType success:(FTT_Callback)success fail:(FTT_Callback)fail {
    //  url 长度为0是， 返回错误
    if (!url || url.length == 0) {
        if (fail) {
            fail(nil,FTT_APIManagerErrorTypeInvalidURL);
        }
        return nil;
    }
    // 会话管理对象为空时
    if (!_sessionManager) {
        [self initSessionManager];
    }
    // 请求成功时的回调
    void (^successWrap)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (!responseObject || (![responseObject isKindOfClass:[NSDictionary class]] && ![responseObject isKindOfClass:[NSArray class]])) // 若解析数据格式异常，返回错误
        {
            if (fail) {
                fail(nil,FTT_APIManagerErrorTypeNoContent);
            }
        }else // 若解析数据正常，判断API返回的code，
        {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders = response.allHeaderFields;
            TT_Log(@"%@",allHeaders);
            responseObject = [NSDictionary changeType:responseObject];
            if (success) {
                success(responseObject,FTT_APIManagerErrorTypeSuccess);
            }
        }
    };

    // 请求失败时的回调
    void (^failureWrap)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        TT_Log(@"%@",error);
        if (fail) {
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
            fail(nil,manager.isReachable ? FTT_APIManagerErrorTypeNoNetWork : FTT_APIManagerErrorTypeTimeout);
        }
    };

    // 设置请求头
    [self formatRequestHeader];
    //  分离URL中的参数信息, 重建参数列表
    params = [self formatParametersForURL:url withParams:params];
    url = [url componentsSeparatedByString:@"?"][0];
    __block NSURLSessionDataTask * urlSessionDataTask;
    if (requestType == FTT_APIManagerRequestTypePOST)  // Post 请求
    {
        // 检查url
        if (![NSURL URLWithString:url]) {
            url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        urlSessionDataTask = [_sessionManager POST:url
                                        parameters:params
                                          progress:nil
                                           success:successWrap
                                           failure:failureWrap];
    }else if (requestType == FTT_APIManagerRequestTypeGET) // Get 请求
    {
        // 检查url
        if (![NSURL URLWithString:url]) {
            url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        urlSessionDataTask = [_sessionManager GET:url
                                       parameters:params
                                         progress:nil
                                          success:successWrap
                                          failure:failureWrap];
    }else if (requestType == FTT_APIManagerRequestTypeUpload) // 上传
    {
        // 检查url
        if (![NSURL URLWithString:url]) {
            url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }

        // POST请求时，分离参数中的字符串参数和文件数据
        NSMutableDictionary *values = [params mutableCopy]; // 保存 字符串参数
        NSMutableDictionary *files = [@{} mutableCopy]; // 保存 文件数据
        [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            // 类型为 NSData 或者 UIImage 时，从参数列表中删除，添加至文件列表，并将UIImage对象转化为NSData类型
            if ([obj isKindOfClass:[NSData class]] || [obj isKindOfClass:[UIImage class]])
            {
                [values removeObjectForKey:key];
                [files setObject:[obj isKindOfClass:[UIImage class]]? UIImageJPEGRepresentation(obj, 0.5): obj forKey:key];
            }
        }];
        urlSessionDataTask = [_sessionManager POST:url
                                        parameters:values
                         constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                             // 将文件列表中的数据逐个添加到请求对象中
                             [files enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSData *obj, BOOL *stop) {
                                 NSString *fileName = [NSString stringWithFormat:@"%ld%c%c.jpg", (long)[[NSDate date] timeIntervalSince1970], arc4random_uniform(26) + 'a', arc4random_uniform(26) + 'a'];
                                 [formData appendPartWithFileData:obj name:@"file" fileName:fileName mimeType:@"image/jpeg"];
                             }];
                         }
                                          progress:nil
                                           success:successWrap
                                           failure:failureWrap];
    }else if (requestType == FTT_APIManagerRequestTypeDownload) //下载
    {

    }else if (requestType == FTT_APIManagerRequestTypeDELECT){
        if (![NSURL URLWithString:url]) {
            url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        urlSessionDataTask =[_sessionManager DELETE:url
                                         parameters:params
                                            success:successWrap
                                            failure:failureWrap];
    }
    return urlSessionDataTask;
}
//  分离URL中的参数信息, 重建参数列表
- (NSDictionary *)formatParametersForURL:(NSString *)url withParams:(NSDictionary *)params{
    NSMutableDictionary *fixedParams = [params mutableCopy];
    //    分离URL中的参数信息
    NSArray *urlComponents = [[url stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@"?"];
    NSArray *paramsComponets = urlComponents.count >= 2 && [urlComponents[1] length] > 0 ? [urlComponents[1] componentsSeparatedByString:@"&"] : nil;
    [paramsComponets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *paramComponets = [obj componentsSeparatedByString:@"="];
        if (!fixedParams[paramsComponets[0]]) {
            [fixedParams setObject:(paramComponets.count>=2 ? paramComponets[1] : @"") forKey:paramComponets[0]];
        }
    }];
    //    检查param的个数，为0时，置为nil
    fixedParams = fixedParams.allKeys.count ? fixedParams : nil;
    return [fixedParams copy];
}

#pragma mark 根据需要设置安全策略
- (AFSecurityPolicy *)creatCustomPolicy {
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    return policy;
}
#pragma mark 根据需要设置请求头信息
- (void)formatRequestHeader {
//    NSString *phoneVersion   = [[UIDevice currentDevice] systemVersion];
//    NSDictionary *infoDic    = [[NSBundle mainBundle] infoDictionary];
//    NSString *currentVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
//    NSString *TOKEN          = [NSString stringWithFormat:@"ios,%@,%@,%@",phoneVersion,[FTT_Helper iphoneType],currentVersion];
//    [_sessionManager.requestSerializer setValue:TOKEN forHTTPHeaderField:@"User-Agent"];
}

@end
