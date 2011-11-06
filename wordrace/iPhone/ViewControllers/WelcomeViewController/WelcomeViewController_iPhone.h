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
    UILabel* titleLabel;
    
    UILabel* playLabel;
    UILabel* levelLabel;
    UILabel* scoresLabel;
    
    UIImageView* playImage;
    UIImageView* levelImage;
    UIImageView* scoresImage;
    
    UIView* landscapeViewForIPad;
    UIView* portraitViewForIPad;
    
    BOOL commenting;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;

@property(nonatomic,retain) IBOutlet UILabel* titleLabel;

@property(nonatomic,retain) IBOutlet UILabel* playLabel;
@property(nonatomic,retain) IBOutlet UILabel* levelLabel;
@property(nonatomic,retain) IBOutlet UILabel* scoresLabel;
@property(nonatomic,retain) IBOutlet UIImageView* playImage;
@property(nonatomic,retain) IBOutlet UIImageView* levelImage;
@property(nonatomic,retain) IBOutlet UIImageView* scoresImage;

@property(nonatomic,retain) IBOutlet UIView* landscapeViewForIPad;
@property(nonatomic,retain) IBOutlet UIView* portraitViewForIPad;


-(IBAction)playTheGame:(id)sender;
-(IBAction)selectLevel:(id)sender;
-(IBAction)showScores:(id)sender;

-(IBAction)playTheGameTouchDown:(id)sender;
-(IBAction)selectLevelTouchDown:(id)sender;
-(IBAction)showScoresTouchDown:(id)sender;

-(IBAction)playTheGameTouchCancel:(id)sender;
-(IBAction)selectLevelTouchCancel:(id)sender;
-(IBAction)showScoresTouchCancel:(id)sender;

-(IBAction)playTheGameTouchDragExit:(id)sender;
-(IBAction)selectLevelTouchDragExit:(id)sender;
-(IBAction)showScoresTouchDragExit:(id)sender;


-(IBAction)showInfo:(id)sender;
@end
