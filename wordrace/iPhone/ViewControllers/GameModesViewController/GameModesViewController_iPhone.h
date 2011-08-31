//
//  GameModesViewController_iPhone.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface GameModesViewController_iPhone : UIViewController
{
    NSManagedObjectContext* managedObjectContext;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;

-(IBAction)goBack:(id)sender;
-(IBAction)playThreeLivesMode:(id)sender;
-(IBAction)playVsTheClockMode:(id)sender;
-(IBAction)playSuddenDeathMode:(id)sender;
@end
