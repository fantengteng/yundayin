//
//  TT_WKweb.m
//  破竹
//
//  Created by linlin dang on 2018/10/9.
//  Copyright © 2018年 米宅. All rights reserved.
//

#import "TT_WKweb.h"
#import "WeakScriptMessageDelegate.h"

#define POST_JS @"function my_post(path, params) {\
var method = \"POST\";\
var form = document.createElement(\"form\");\
form.setAttribute(\"method\", method);\
form.setAttribute(\"action\", path);\
for(var key in params){\
if (params.hasOwnProperty(key)) {\
var hiddenFild = document.createElement(\"input\");\
hiddenFild.setAttribute(\"type\", \"hidden\");\
hiddenFild.setAttribute(\"name\", key);\
hiddenFild.setAttribute(\"value\", params[key]);\
}\
form.appendChild(hiddenFild);\
}\
document.body.appendChild(form);\
form.submit();\
}"
//系统版本判断
#define SystemVersion [[UIDevice currentDevice].systemVersion intValue]

@interface TT_WKweb ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate,UIScrollViewDelegate>
/// 配置文件
@property (nonatomic , strong) WKWebViewConfiguration *config;

@property (nonatomic , assign) BOOL contentSizeHeight;

@property (nonatomic, strong) WKUserScript *userScript;



@end



@implementation TT_WKweb


#pragma mark 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initsubViewS];
    }
    return self;
}

- (void)dealloc {
    @try {
        [self.wkweb removeObserver:self forKeyPath:@"title"];
        [self.wkweb removeObserver:self forKeyPath:@"estimatedProgress"];
        if (self.contentSizeHeight) {
            [self.wkweb.scrollView removeObserver:self forKeyPath:@"contentSize"];
        }
    }
    @catch (NSException *exception) {
    
    }
    if (self.configName) {
          [self.wkweb.configuration.userContentController removeScriptMessageHandlerForName:self.configName];
    }
    if (self.wkweb) {
        self.wkweb.navigationDelegate  = nil;
        self.wkweb.UIDelegate          = nil;
        self.wkweb.scrollView.delegate = nil;
    }
}
#pragma mark 回调协议

/// JS 触发方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WKwebJScallOCdidReceiveScriptMessage:)]) {
        [self.TT_WKDelegate TT_WKwebJScallOCdidReceiveScriptMessage:message];
    }
}


/// ===== WKUIDelegate ===== ///

//* 在JS端调用alert函数时，会触发此代理方法。JS端调用alert时所传的数据可以通过message拿到。在原生得到结果后，需要回调JS，是通过completionHandler回调。
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
}

//* JS端调用confirm函数时，会触发此方法，通过message可以拿到JS端所传的数据，在iOS端显示原生alert得到YES/NO后，通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
//    NSLog(@"message = %@",message);
}

//* JS端调用prompt函数时，会触发此方法,要求输入一段文本,在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {

}

/// ===== WKNavigationDelegate ===== ///


/// * 判断链接是否允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
//    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebdecidePolicyForNavigationAction:)]) {
//        [self.TT_WKDelegate TT_WkwebdecidePolicyForNavigationAction:navigationAction];
//    }
//    /* 简单判断host，真实App代码中，需要更精确判断itunes链接 */
//    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] && [[UIApplication sharedApplication] openURL:navigationAction.request.URL]){
//        policy =WKNavigationActionPolicyCancel;
//        decisionHandler(policy);
//        return;
//    }
//
    
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {//跳转别的应用如系统浏览器
                    // 对于跨域，需要手动跳转
                    [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
                    // 不允许web内跳转
                    decisionHandler(WKNavigationActionPolicyCancel);
                    return;
    }
    // 对于跨域，需要手动跳转
//    [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//    // 不允许web内跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
//    return;



//    if (navigationAction.request.URL.host == nil) {
//        if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {//跳转别的应用如系统浏览器
//            // 对于跨域，需要手动跳转
//            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//            // 不允许web内跳转
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        }
//        NSArray *schemeArr = @[@"mailto",@"tel"];
//        if (![schemeArr containsObject:navigationAction.request.URL.scheme]) {
//            policy = WKNavigationActionPolicyCancel;
//            decisionHandler(policy);
//            return;
//        }
//
//    }
//
//
//    if (self.Is_jump && ([navigationAction.request.URL.path hasSuffix:@"/views/lecture/article.html"])) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        return;
//    }
//
    decisionHandler(policy);
    return;

}


/// * 链接开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebrequeStatus:)]) {
        [self.TT_WKDelegate TT_WkwebrequeStatus:TT_WKwebRequestStatusStart];
    }
}

/// * 当内容开始到达主帧时被调用（即将完成）
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebrequeStatus:)]) {
        [self.TT_WKDelegate TT_WkwebrequeStatus:TT_WKwebRequestStatusdidCommit];
    }
}

/// * 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self web_pvframeis_Hide:NO];
    [self loadwkwebviewImageArr];
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebrequeStatus:)]) {
        [self.TT_WKDelegate TT_WkwebrequeStatus:TT_WKwebRequestStatusFinish];
    }
}

/// * 加载错误时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self web_pvframeis_Hide:NO];
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebrequeStatus:)]) {
        [self.TT_WKDelegate TT_WkwebrequeStatus:TT_WKwebRequestStatusFail];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]){
        self.wkweb_title = self.wkweb.title;
    }else if ([keyPath isEqualToString:@"estimatedProgress"]){
        [self.wkweb_pv animationWith:self.wkweb.estimatedProgress];
    }else if ([keyPath isEqualToString:@"contentSize"]) {
        //更具内容的高重置webView视图的高度
        CGFloat newHeight = self.wkweb.scrollView.contentSize.height;
        [self configcontentSizeHeight:newHeight];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.is_firstSlide) {
        [self CreateUp_DowN_BacKForUIScrollView:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 获取开始拖拽时tableview偏移量
    _oldY = scrollView.contentOffset.y;
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebscrollViewWillBeginDragging:)]) {
        [self.TT_WKDelegate TT_WkwebscrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self CreateUp_DowN_BacKForUIScrollView:scrollView];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self CreateUp_DowN_BacKForUIScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self CreateUp_DowN_BacKForUIScrollView:scrollView];
    }
}

- (void)CreateUp_DowN_BacKForUIScrollView:(UIScrollView *)scrollView {
    BOOL YorN;
    if (scrollView.contentOffset.y > _oldY ) {
        YorN = NO;
    }else{
        YorN = YES;
    }
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WkwebDidScroll:UporDown:)]) {
        [self.TT_WKDelegate TT_WkwebDidScroll:scrollView UporDown:YorN];
    }
}



#pragma mark 触发方法

/// 加载数据
- (void)loadRefare {
    [self.wkweb stopLoading];
    NSURL *URL = [NSURL URLWithString:self.wkweb_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.wkweb loadRequest:request];
    [self configWKwebviewKVO];
}

/// 设置KVO
- (void)configWKwebviewKVO {
    
    [self.wkweb addObserver:self
                    forKeyPath:@"title"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    [self.wkweb addObserver:self
                    forKeyPath:@"estimatedProgress"
                       options:NSKeyValueObservingOptionNew
                       context:nil];
}

/// 改变进度条的位置
- (void)web_pvframeis_Hide:(BOOL)YorN {
    CGFloat Y;
    if (YorN) {
        Y = self.wkweb_pvY;
    }else {
        Y = self.frame.size.height * 2;
    }
    self.wkweb_pv.frame = CGRectMake(0, Y, self.frame.size.width, 5);
}

#pragma mark 公开方法

/// 获取数据
- (void)loadRequest:(NSString *)url data:(NSString *)data requestStatus:(TT_WKwebType)Status{
    if (Status == GET) {
         self.wkweb_url = [NSString stringWithFormat:@"%@?%@",url,data];
         [self loadRefare];
        
    }else {
        NSString *js = [NSString stringWithFormat:@"%@my_post(\"%@\",%@)",POST_JS,url,data];
        [self.wkweb evaluateJavaScript:js completionHandler:nil];
    }
    [self web_pvframeis_Hide:YES];
}

/// 设置b偏移量
- (void)wkwebconfigOffestY:(CGFloat)offestY {
    self.wkweb.scrollView.contentInset = UIEdgeInsetsMake(offestY, 0, 0, 0);
}

/// OC -> JS
- (void)wkwebOCtouchJS:(NSString *)javaScript {
    [self.wkweb evaluateJavaScript:javaScript
                 completionHandler:^(id _Nullable item, NSError * _Nullable error) {
    
                 }];
}

- (void)configcontentSizeHeight:(CGFloat)newHeight {
    if (self.TT_WKDelegate && [self.TT_WKDelegate respondsToSelector:@selector(TT_WKwebContentSizeHeight:)]) {
        [self.TT_WKDelegate TT_WKwebContentSizeHeight:newHeight];
    }
}

- (BOOL)wkwebgoback {
    if (self.wkweb.canGoBack) {
        [self.wkweb goBack];
    }else {
        [self.wkweb stopLoading];
    }
    return self.wkweb.canGoBack;
}

+ (void)Clear {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
//        NSLog(@"清楚缓存完毕");
    }];
}
#pragma mark 私有方法

/// 添加视图
- (void)initsubViewS {
    self.oldY = 0;
    self.wkweb_pvY = 0;
    self.Is_jump = YES;
    [self addSubview:self.wkweb];
    self.wkweb.UIDelegate = self;
    self.wkweb.scrollView.delegate = self;
    self.wkweb.navigationDelegate  = self;
    [self addSubview:self.wkweb_pv];
    
}

- (void)loadwkwebviewImageArr {
    @weakify(self)
    //获取图片数组
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //获取图片数组
        @strongify(self)
        [self.wkweb evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSMutableArray *imgSrcArray = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@"+"]];
            if (imgSrcArray.count >= 2) {
                [imgSrcArray removeLastObject];
            }
            self.ImageUrlArr = [NSMutableArray new];
            for (NSInteger i = 0; i < imgSrcArray.count; i++) {
                if ([imgSrcArray[i] hasSuffix:@".gif"] || [imgSrcArray[i] containsString:@"www.pozhu.com/upload"] ||  [imgSrcArray[i] containsString:@"pozhucdn.mizhai.com/Uploads"] || [imgSrcArray[i] containsString:@"newsimgs.mizhai.com"] ||[imgSrcArray[i] containsString:@"imga.pozhu.com"]) {
                    [self.ImageUrlArr addObject:imgSrcArray[i]];
                }
            }
        }];
        [self.wkweb evaluateJavaScript:@"registerImageClickAction();" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
       
        }];
    });
}
#pragma mark 存取方法


- (void)setConfigName:(NSString *)configName {
    _configName = configName;
    [self.config.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc]initWithDelegate:self] name:configName];
}

- (TT_ProgressV *)wkweb_pv {
    if (!_wkweb_pv) {
        _wkweb_pv = [[TT_ProgressV alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 5)];
    }
    return _wkweb_pv;
}

- (WKWebView *)wkweb {
    if (!_wkweb) {
        _wkweb= [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) configuration:self.config];
        _wkweb.scrollView.bounces = NO;
        [_wkweb setAllowsBackForwardNavigationGestures:true];
    }
    return _wkweb;
}

- (WKWebViewConfiguration *)config {
    if (!_config) {
        _config = [[WKWebViewConfiguration alloc]init];
        WKPreferences *WKP = [WKPreferences new];
        WKP.minimumFontSize = 10;
        /// javaScript 打开
        WKP.javaScriptEnabled = YES;
        /// 控制javaScript 打开Windows
        WKP.javaScriptCanOpenWindowsAutomatically = YES;
        _config.preferences = WKP;
        _config.processPool = [[WKProcessPool alloc]init];
        _config.userContentController = [[WKUserContentController alloc]init];
        [_config.userContentController addUserScript:self.userScript];
        if (SystemVersion >= 9.0) {
            /// 是否允许点击图片
            _config.allowsPictureInPictureMediaPlayback = YES;
            /// 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
            _config.allowsInlineMediaPlayback = YES;
        }
    }
    return _config;
}


- (WKUserScript *)userScript
{
    if (!_userScript) {
        static  NSString * const jsGetImages =
        @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        var imgScr = '';\
        for(var i=0;i<objs.length;i++){\
        imgScr = imgScr + objs[i].src + '+';\
        };\
        return imgScr;\
        };function registerImageClickAction(){\
        var imgs=document.getElementsByTagName('img');\
        var length=imgs.length;\
        for(var i=0;i<length;i++){\
        img=imgs[i];\
        img.onclick=function(){\
        window.location.href='image-preview:'+this.src}\
        }\
        }";
        _userScript = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    }
    return _userScript;
}




@end
