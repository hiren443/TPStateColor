//
//  AppDelegate.m
//  WXState
//
//  Created by digi on 31/12/13.
//  Copyright (c) 2013 TechnoPote. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewCntrl.h"
#import "TPMapController.h"
#import "MenuViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.menuLeftViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    self.home = [[HomeViewCntrl alloc] initWithNibName:@"HomeViewCntrl" bundle:nil];
    self.map = [[TPMapController alloc] initWithNibName:@"TPMapController" bundle:Nil];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45.0/255.0 green:150.0/255.0 blue:184.0/255.0 alpha:1.0];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.map];
    
    self.container = [MFSideMenuContainerViewController containerWithCenterViewController:self.navigationController
																   leftMenuViewController:self.menuLeftViewController
																  rightMenuViewController:nil];

//    self.window.backgroundColor = [UIColor whiteColor];
  	self.window.rootViewController = self.container;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void) showHomeAnimated:(BOOL)animated {
}

-(void)selectMenu:(NSString*)region {
    
    [self.home loadMap:region];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
