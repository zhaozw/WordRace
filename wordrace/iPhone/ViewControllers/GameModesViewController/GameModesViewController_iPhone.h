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
    UILabel* gameModesTitleLabel;
    
    UILabel* threeLivesLabel;
    UILabel* vsTheClockLabel;
    UILabel* suddenDeathLabel;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;
@property(nonatomic,retain) IBOutlet UILabel* gameModesTitleLabel;
@property(nonatomic,retain) IBOutlet UILabel* threeLivesLabel;
@property(nonatomic,retain) IBOutlet UILabel* vsTheClockLabel;
@property(nonatomic,retain) IBOutlet UILabel* suddenDeathLabel;

-(IBAction)goBack:(id)sender;
-(IBAction)playThreeLivesMode:(id)sender;
-(IBAction)playVsTheClockMode:(id)sender;
-(IBAction)playSuddenDeathMode:(id)sender;

-(IBAction)playThreeLivesModeTouchDown:(id)sender;
-(IBAction)playVsTheClockModeTouchDown:(id)sender;
-(IBAction)playSuddenDeathModeTouchDown:(id)sender;

-(IBAction)playThreeLivesModeTouchCancel:(id)sender;
-(IBAction)playVsTheClockModeTouchCancel:(id)sender;
-(IBAction)playSuddenDeathModeTouchCancel:(id)sender;

-(IBAction)playThreeLivesModeTouchDragExit:(id)sender;
-(IBAction)playVsTheClockModeTouchDragExit:(id)sender;
-(IBAction)playSuddenDeathModeTouchDragExit:(id)sender;


@end
