//
//  PauseViewController.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PauseViewController : UIViewController
{
    UIViewController* parentGamePlayViewController;
    
    NSUInteger currentGameMode;
    NSUInteger currentLevel;
    UILabel* pauseTitleLabel;
    
    UILabel* continueLabel;
    UILabel* restartLabel;
    UILabel* goToMainMenuLabel;
    
    UIImageView* continueImage;
    UIImageView* restartImage;
    UIImageView* goToMainMenuImage;

}
@property(nonatomic,assign) UIViewController* parentGamePlayViewController;
@property(nonatomic,assign) NSUInteger currentGameMode;
@property(nonatomic,assign) NSUInteger currentLevel;
@property(nonatomic,retain) IBOutlet UILabel* pauseTitleLabel;

@property(nonatomic,retain) IBOutlet UILabel* continueLabel;
@property(nonatomic,retain) IBOutlet UILabel* restartLabel;
@property(nonatomic,retain) IBOutlet UILabel* goToMainMenuLabel;

@property(nonatomic,retain) IBOutlet UIImageView* continueImage;
@property(nonatomic,retain) IBOutlet UIImageView* restartImage;
@property(nonatomic,retain) IBOutlet UIImageView* goToMainMenuImage;

-(IBAction)continueGame:(id)sender;
-(IBAction)restartGame:(id)sender;
-(IBAction)goToMainMenu:(id)sender;

-(IBAction)continueGameTouchDown:(id)sender;
-(IBAction)restartGameTouchDown:(id)sender;
-(IBAction)goToMainMenuTouchDown:(id)sender;

-(IBAction)continueGameTouchCancel:(id)sender;
-(IBAction)restartGameTouchCancel:(id)sender;
-(IBAction)goToMainMenuTouchCancel:(id)sender;

-(IBAction)continueGameTouchDragExit:(id)sender;
-(IBAction)restartGameTouchDragExit:(id)sender;
-(IBAction)goToMainMenuTouchDragExit:(id)sender;

@end
