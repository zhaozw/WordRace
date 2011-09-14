//
//  wordraceAppDelegate.h
//  wordrace
//
//  Created by Taha Selim Bebek on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface wordraceAppDelegate : NSObject <UIApplicationDelegate> 
{
    Facebook* facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) Facebook* facebook;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSString *)applicationDocumentsDirectoryPath;

@end
