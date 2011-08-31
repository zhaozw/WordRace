//
//  WelcomeViewController_iPhone.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface WelcomeViewController_iPhone : UIViewController
{
    NSManagedObjectContext* managedObjectContext;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;

-(IBAction)playTheGame:(id)sender;
-(IBAction)selectLevel:(id)sender;
-(IBAction)showScores:(id)sender;
-(IBAction)showInfo:(id)sender;
@end
