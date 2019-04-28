//
//  TT_WKwebC.m
//  TT_Wkweb
//
//  Created by linlin dang on 2018/12/21.
//  Copyright © 2018 FTT. All rights reserved.
//

#import "TT_WKwebC.h"

@interface TT_WKwebC ()


@end

@implementation TT_WKwebC


#pragma mark 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    IPhoneXHeigh
    self.Web_frame = CGRectMake(0, securitytop_Y, KScreenWidth, security_H);
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSubViewS];
    [self initnavgationItemS];
    [self changeDefaultConfiguration];
    [self configWKwebC_allClose];
}

#pragma mark 回调协议

/// 加载状态
- (void)TT_WkwebrequeStatus:(TT_WKwebRequestStatus)Status {
    if (Status == TT_WKwebRequestStatusFinish) {
        self.title = self.Web.wkweb_title;
    }
}

/// JS -> OC
- (void)TT_WKwebJScallOCdidReceiveScriptMessage:(WKScriptMessage *)message {
    [self configJSinvokeOCinfo:message];
}

/// 截取URL
- (void)TT_WkwebdecidePolicyForNavigationAction:(WKNavigationAction *)navigationAction {
    [self configWebImageNavigation:navigationAction];
}

/// 滑动
- (void)TT_WkwebDidScroll:(UIScrollView *)ScrollView UporDown:(BOOL)YorN {
    
}

/// 手动 滑动
- (void)TT_WkwebscrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

#pragma mark 触发方法



#pragma mark 公开方法

/// 添加视图
- (void)initSubViewS {
    [self.view addSubview:self.Web];
}

/// 添加导航栏按钮
- (void)initnavgationItemS {
    
}

/// 修改默认属性
- (void)changeDefaultConfiguration {
    
}

/// 配置回调
- (void)configWKwebC_allClose {
    
}

/// WK 刷新
- (void)configWKweb_reload {
    [self.Web.wkweb reload];
}

/// H5 返回上一个界面
- (void)configWKweb_goBack {
    if (![self.Web wkwebgoback]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/// 加载网络请求
- (void)configloadRequestWKweb_Url:(NSString *)WKweb_Url WKweb_data:(NSString *)WKweb_data WKweb_requesStatus:(TT_WKwebType)WKweb_requesStatus {
    [self.Web loadRequest:WKweb_Url data:WKweb_data requestStatus:WKweb_requesStatus];
}

/// 设置自定义控件的显示隐藏
- (void)configPublicmenthodcontrolisHide:(BOOL)Ishide {
    
}

/// 获取图片信息
- (void)configWebImageNavigation:(WKNavigationAction *)NavigationAction {
    
}

/// JS -> OC
- (void)configJSinvokeOCinfo:(WKScriptMessage *)info {
    
}

/// OC -> JS
- (void)configwkwebOCtouchJS:(NSString *)javaScript {
    [self.Web wkwebOCtouchJS:javaScript];
}

#pragma mark 私有方法




#pragma mark 存取方法


- (void)setWeb_configName:(NSString *)Web_configName {
    _Web_configName = Web_configName;
    self.Web.configName = Web_configName;
}


- (TT_WKweb *)Web {
    if (!_Web) {
        IPhoneXHeigh
        _Web = [[TT_WKweb alloc]initWithFrame:self.Web_frame];
        _Web.TT_WKDelegate = self;
        _Web.is_firstSlide = YES;
        _Web.wkweb_pv.ColosArray =  [NSArray arrayWithObjects:(id)[UIColor grayColor].CGColor,(id)[UIColor grayColor].CGColor ,(id)[UIColor grayColor].CGColor ,nil];
    }
    return _Web;
}

@end
