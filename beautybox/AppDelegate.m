//
//  AppDelegate.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "AppDelegate.h"
#import <InstagramEngine.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <VKSdk.h>
#import "Singleton.h"
#import "Api.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [Singleton shared].domen=@"http://beautybox.ru";
    [GMSServices provideAPIKey:api_key];

    if(TOKEN)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Main"];
        self.window.rootViewController=myVC;
    }
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    [VKSdk processOpenURL:url fromApplication:sourceApplication];
    
    
    return YES;
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
           options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if (@available(iOS 9.0, *)) {
        
        [[FBSDKApplicationDelegate sharedInstance] application:application
                                                       openURL:url
                                             sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                    annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
         ];
        
      
        [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    }
    // Add any custom logic here.
    return YES;
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
