//
//  AppDelegate.h
//  WXState
//
//  Created by digi on 31/12/13.
//  Copyright (c) 2013 TechnoPote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenuContainerViewController.h"
#import "HomeViewCntrl.h"
#import "TPMapController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MFSideMenuContainerViewController *container;
@property (strong, nonatomic) UIViewController *menuLeftViewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) HomeViewCntrl *home;
@property (strong, nonatomic) TPMapController *map;

-(void)selectMenu:(NSString*)region;
@end
