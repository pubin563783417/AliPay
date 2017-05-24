//
//  AppDelegate.m
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen] .bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    _window.rootViewController = [self tabBarVC];
    return YES;
}
- (CYLTabBarController *)tabBarVC{
    NSArray *classs = @[@"ZFBFirstRootVC",@"ZFBGoodPriceVC",@"ZFBFriendFootVC",@"ZFBMineFootVC"];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < classs.count; i ++) {
         UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[self tabBarVCWithClass:classs[i]]];
        [vcs addObject:navi];
                                         
    }
   
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    [tabBarController setViewControllers:vcs];
                                    
    
    return tabBarController;
}
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"TabBar_HomeBar",
                            CYLTabBarItemSelectedImage : @"TabBar_HomeBar_Sel"
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"口碑",
                            CYLTabBarItemImage : @"TabBar_Businesses",
                            CYLTabBarItemSelectedImage : @"TabBar_Businesses_Sel"
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"朋友",
                            CYLTabBarItemImage : @"TabBar_Friends",
                            CYLTabBarItemSelectedImage : @"TabBar_Friends_Sel"
                            };
    
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"TabBar_Assets",
                            CYLTabBarItemSelectedImage : @"TabBar_Assets_Sel"
                            };
    NSArray *tabBarItemsAttributes = @[dict1,dict2,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}
- (UIViewController *)tabBarVCWithClass:(NSString *)classString{
    Class class = NSClassFromString(classString);
    UIViewController *vc = [[class alloc] init];
    return vc;
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
