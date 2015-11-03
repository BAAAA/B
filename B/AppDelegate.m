//
//  AppDelegate.m
//  B
//
//  Created by lanou on 15/10/27.
//  Copyright (c) 2015年 朱瑶瑶. All rights reserved.
//

#import "AppDelegate.h"
#import "TravelViewController.h"
#import "VideoViewController.h"
#import "DestinationViewController.h"
#import "MyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [self.window makeKeyAndVisible];

    TravelViewController *travelVC = [[TravelViewController alloc] init];
    UINavigationController *travelNC = [[UINavigationController alloc] initWithRootViewController:travelVC];
    travelNC.tabBarItem.image = [UIImage imageNamed:@"homeIcon.png"];
    
    VideoViewController *videoVC = [[VideoViewController alloc] init];
    UINavigationController *videoNC = [[UINavigationController alloc] initWithRootViewController:videoVC];
    videoNC.tabBarItem.image = [UIImage imageNamed:@"videoIcon.png"];
    
    
    DestinationViewController *destinationVC = [[DestinationViewController alloc] init];
    UINavigationController *destinationNC = [[UINavigationController alloc] initWithRootViewController:destinationVC];
    destinationNC.tabBarItem.image = [UIImage imageNamed:@"localIcon.png"];
    
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *myNC = [[UINavigationController alloc] initWithRootViewController:myVC];
    myNC.tabBarItem.image = [UIImage imageNamed:@"peopleIcon.png"];
    
    
    UITabBarController *tabBC = [[UITabBarController alloc] init];
    tabBC.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    [tabBC setViewControllers:@[travelNC, videoNC, destinationNC, myNC]];
    self.window.rootViewController = tabBC;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
