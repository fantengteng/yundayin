//
//  TabBarTool.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/3/26.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TabBarTool.h"
#import "AppDelegate.h"
#import "JMTabBarController.h"
#import "HomeC.h"
#import "MyC.h"
#import "LoginC.h"
@interface TT_BaseNavigationController : UINavigationController

@end

@implementation TT_BaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if (!IPHONE_X) {
            viewController.hidesBottomBarWhenPushed = YES;
        }else {
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

@end

@implementation TabBarTool

+ (instancetype)Share_TabBarTool {
    static TabBarTool *TT = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TT = [[TabBarTool alloc]init];
    });
    return TT;
}


- (void)CreateLoginC {
    LoginC *LC = [[LoginC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:LC];
    AppDelegate* appDelagete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelagete.window.rootViewController = nav;
}

- (void)CreateTabBar {
   
    JMConfig *config = [JMConfig config];
    config.imageSize = CGSizeMake(24, 24);
    config.imageOffset = 7;
    config.norTitleColor = Col_999;
    config.selTitleColor = Col_04D;
    config.typeLayout = JMConfigTypeLayoutNormal;
    
    config.tabBarAnimType = JMConfigTabBarAnimTypeRotationY;
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"云打印",@"个人中心", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"shouye2",@"wode2", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"shouye1",@"wode1", nil];
    NSMutableArray *controllersArr = [NSMutableArray array];
    
    HomeC *firstViewController = [[HomeC alloc] init];
    UIViewController *firstNavigationController = [[TT_BaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
     MyC *fivethViewController = [[MyC alloc] initWithNibName:@"MyC" bundle:nil];
    UIViewController *fivethNavigationController = [[TT_BaseNavigationController alloc]
                                                    initWithRootViewController:fivethViewController];
    
    [controllersArr addObject:firstNavigationController];
    [controllersArr addObject:fivethNavigationController];
    
    JMTabBarController *tabBar = [[JMTabBarController alloc]initWithTabBarControllers:controllersArr NorImageArr:imageNormalArr SelImageArr:imageSelectedArr TitleArr:titleArr Config:config];
    AppDelegate* appDelagete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelagete.window.rootViewController = tabBar;
}

@end
