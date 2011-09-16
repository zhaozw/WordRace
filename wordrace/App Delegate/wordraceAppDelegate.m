//
//  wordraceAppDelegate.m
//  wordrace
//
//  Created by Taha Selim Bebek on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "wordraceAppDelegate.h"
#import "Constants.h"

@implementation wordraceAppDelegate


@synthesize window=_window;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;
@synthesize facebook;

@synthesize currentPlayerID, gameCenterAuthenticationComplete;


BOOL isGameCenterAPIAvailable()
{
    // Check for presence of GKLocalPlayer API.
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // The device must be running running iOS 4.1 or later.
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported); 
}

- (void)authenticateLocalPlayer
{    
    if (!isGameCenterAPIAvailable()) {
        // Game Center is not available. 
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"gameCenterAvailable"];
        [defaults setObject:@"Game Center kullanmak icin iOS versiyon minimum 4.1 olmalidir." forKey:@"gameCenterNotAvailableReason"];
        NSLog(@"Game center api not available");
    } else {
        
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        
        /*
         The authenticateWithCompletionHandler method is like all completion handler methods and runs a block
         of code after completing its task. The difference with this method is that it does not release the 
         completion handler after calling it. Whenever your application returns to the foreground after 
         running in the background, Game Kit re-authenticates the user and calls the retained completion 
         handler. This means the authenticateWithCompletionHandler: method only needs to be called once each 
         time your application is launched. This is the reason the sample authenticates in the application 
         delegate's application:didFinishLaunchingWithOptions: method instead of in the view controller's 
         viewDidLoad method.
         
         Remember this call returns immediately, before the user is authenticated. This is because it uses 
         Grand Central Dispatch to call the block asynchronously once authentication completes.
         */
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
            // If there is an error, do not assume local player is not authenticated. 
            if (localPlayer.isAuthenticated) {
                NSLog(@"Game center available");
                // Enable Game Center Functionality 
                self.gameCenterAuthenticationComplete = YES;
                NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"gameCenterAvailable"];
               
                if (! self.currentPlayerID || ! [self.currentPlayerID isEqualToString:localPlayer.playerID]) {
                    
                    // Current playerID has changed. Create/Load a game state around the new user. 
                    self.currentPlayerID = localPlayer.playerID;
                    NSLog(@"Player ID = %@", [localPlayer playerID]);
                    NSLog(@"Player Alias = %@", [localPlayer alias]);
                    [defaults setObject:[localPlayer playerID] forKey:@"PlayerID"];
                    [defaults setObject:[localPlayer alias] forKey:@"PlayerAlias"];

                    // Load game instance for new current player, if none exists create a new.
                }
            } else {     
                // No user is logged into Game Center, run without Game Center support or user interface. 
                NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:NO forKey:@"gameCenterAvailable"];
                [defaults setObject:[error localizedDescription] forKey:@"gameCenterNotAvailableReason"];
                NSLog(@"Game center not available");
            }
        }];
    }    

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [self.facebook handleOpenURL:url]; 
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self authenticateLocalPlayer];
    
    /*
    if (gameCenterAvailable) {
        NSLog(@"gameCenterAvailable");
        [self authenticateLocalPlayer];
    }
    else
    {
    }
     */
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)dealloc
{
    [facebook release];
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WordraceModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = nil;
    NSDictionary *options =nil;
    NSError *error = nil;

    if (BUILDDATABASEMODE) 
    {
        storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WordRaceDB_turkish.sqlite"];
        __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    }
    else
    {
        NSString* dataBaseFileNameWithExtension = [NSString stringWithFormat:@"WordRaceDB_%@.sqlite",LANGUAGE];
        NSString* dataBaseFileNameWithoutExtension = [NSString stringWithFormat:@"WordRaceDB_%@",LANGUAGE];
        
        NSString *storePath = [[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:dataBaseFileNameWithExtension];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:storePath]) {
            NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:dataBaseFileNameWithoutExtension ofType:@"sqlite"];
            if (defaultStorePath) [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
        }
		
        options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        storeURL = [NSURL fileURLWithPath:storePath];
        
        __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    }
   
      
     if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"%s Unresolved error %@, %@", __FUNCTION__,error, [error userInfo]);
        //abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */

- (NSString *)applicationDocumentsDirectoryPath 
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
