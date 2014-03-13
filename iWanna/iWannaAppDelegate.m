//
//  iWannaAppDelegate.m
//  iWanna
//
//  Created by Aidan on 01/03/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "iWannaAppDelegate.h"

@implementation iWannaAppDelegate
{
    DataModel *_dataModel;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _dataModel = [[DataModel alloc] init];//creates dataModel
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;//finds all AllListViewControllers
    AllListsViewController *controller = navigationController.viewControllers[0];
    controller.dataModel = _dataModel;//sets DataModel Property
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)saveData {
    [_dataModel saveiWannaLists];//call the save fucntion
    [_dataModel getBadgeNumber];//calls the getBadgeNumber funcition
}
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];//called when home button is pressed
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
        [self saveData];//called when app goes to the background
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
@end