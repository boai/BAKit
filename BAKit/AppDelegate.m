//
//  AppDelegate.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+BALaunch.h"

#import "BAUIKitViewController.h"
#import "BAFoundationViewController.h"
#import "BAOtherViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self ba_setupTabBarVC];
    [self ba_setupLaunch];

    return YES;
}

- (void)ba_setupTabBarVC
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 自定义配置：tabbar 的背景颜色 和 item 颜色
    [BAKit_Helper ba_helperSetTabbarSelectedTintColor:BAKit_Color_Red
                                      normalTintColor:BAKit_Color_White
                                      backgroundImage:nil
                                      backgroundColor:BAKit_Color_Black];
    // 自定义配置：状态栏颜色
    [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:NO];
    
    // 自定义配置：navi 颜色
//    [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_White tintColor:BAKit_Color_Black font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_Black isNeedBackTitle:NO isNeedBottomLine:YES customShadowImage:BAKit_ImageName(@"navi_shadow") navigationController:self.navigationController];

    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    
    BAUIKitViewController *uikitVC = [BAUIKitViewController new];
    BANavigationController *uikitNavi = [[BANavigationController alloc] initWithRootViewController:uikitVC];
    uikitNavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"BAUIKit" image:BAKit_ImageName(@"tabbar_mainframe") selectedImage:BAKit_ImageName(@"tabbar_mainframeHL") selectedTitleColor:nil tag:0];
    uikitVC.title = uikitNavi.tabBarItem.title;
    
    BAFoundationViewController *foundationVC = [BAFoundationViewController new];
    BANavigationController *foundationNavi = [[BANavigationController alloc] initWithRootViewController:foundationVC];
    foundationNavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"BAFoundation" image:BAKit_ImageName(@"tabbar_contacts") selectedImage:BAKit_ImageName(@"tabbar_contactsHL") selectedTitleColor:nil tag:1];
    foundationVC.title = foundationNavi.tabBarItem.title;

    BAOtherViewController *otherVC = [BAOtherViewController new];
    BANavigationController *otherNavi = [[BANavigationController alloc] initWithRootViewController:otherVC];
    otherNavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"Other" image:BAKit_ImageName(@"tabbar_discover") selectedImage:BAKit_ImageName(@"tabbar_discoverHL") selectedTitleColor:nil tag:2];
    otherVC.title = otherNavi.tabBarItem.title;

    /**
     tabBarVC 获取不到tabBarItem实例,demo为了演示效果做了0.1s的延时操作,
     在实际开发中,badge的显示是在网络请求成功/推送之后,所以不用担心获取不到tabBarItem添加不了badge
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 给UITabBarItem添加badge
        [uikitNavi.tabBarItem ba_addBadgeWithText:@"new"];
        [foundationNavi.tabBarItem ba_addBadgeWithNumber:999];
        [otherNavi.tabBarItem ba_addDotWithColor:BAKit_Color_Red];
    });
    
    self.tabBarController.viewControllers = @[uikitNavi, foundationNavi, otherNavi];
    self.tabBarController.selectedIndex = 0;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController.tabBarItem ba_hiddenBadge];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
