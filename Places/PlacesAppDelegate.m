//
//  PlacesAppDelegate.m
//  Places
//
//  Created by Matt Augustine on 4/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlacesAppDelegate.h"
#import "FlickrFetcher.h"
#import "PlacesTableViewController.h"
#import "RecentPhotosTableViewController.h"

@implementation PlacesAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Test Flickr call
    //NSLog(@"%@", [FlickrFetcher topPlaces]);
    
    // Create a Navigation controller for the Places tab
    PlacesTableViewController *placesTVCon = [[PlacesTableViewController alloc] init];
    placesTVCon.title = @"Places";
    placesTVCon.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:0];
    UINavigationController *placesNavCon = [[UINavigationController alloc] init];
    [placesNavCon pushViewController:placesTVCon animated:NO];
    
    // Create a Navigation controller for the Recent Photos tab
    RecentPhotosTableViewController *recentTVCon = [[RecentPhotosTableViewController alloc] init];
    recentTVCon.title = @"Recent Photos";
    recentTVCon.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:0];
    UINavigationController *recentNavCon = [[UINavigationController alloc] init];
    [recentNavCon pushViewController:recentTVCon animated:NO];
    
    // Create UITabBarController
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    // Add two navigation controllers to UITabBarController
    tabBar.viewControllers = [NSArray arrayWithObjects:placesNavCon, recentNavCon, nil];
    
    // Add UITabBarController to main window
    [self.window addSubview:tabBar.view];
    
    // Release view controllers
    [placesTVCon release];
    [recentTVCon release];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
