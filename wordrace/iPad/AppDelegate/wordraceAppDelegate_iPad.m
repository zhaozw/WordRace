//
//  wordraceAppDelegate_iPad.m
//  wordrace
//
//  Created by Taha Selim Bebek on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "wordraceAppDelegate_iPad.h"

@implementation wordraceAppDelegate_iPad

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarHidden = YES;
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)dealloc
{
	[super dealloc];
}

@end
