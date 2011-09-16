//
//  PauseViewController.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PauseViewController.h"
#import "ThreeLivesViewController_iPhone.h"
#import "VsTheClockViewController_iPhone.h"
#import "SuddenDeathViewController_iPhone.h"
#import "Constants.h"

@implementation PauseViewController
@synthesize parentGamePlayViewController;
@synthesize currentGameMode;
@synthesize currentLevel;
@synthesize pauseTitleLabel;
@synthesize continueImage;
@synthesize continueLabel;
@synthesize restartImage;
@synthesize restartLabel;
@synthesize goToMainMenuImage;
@synthesize goToMainMenuLabel;


#pragma mark -
#pragma mark ibaction

-(IBAction)continueGame:(id)sender
{
    self.continueImage.frame = CGRectOffset(self.continueImage.frame, 0, 3);
    self.continueLabel.frame = CGRectOffset(self.continueLabel.frame, 0, 3);

    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)restartGame:(id)sender
{
    self.restartImage.frame = CGRectOffset(self.restartImage.frame, 0, 3);
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, 3);

    ThreeLivesViewController_iPhone* parentGamePlayViewControllerThreeLives =nil;
    VsTheClockViewController_iPhone* parentGamePlayViewControllerVsTheClock =nil;
    SuddenDeathViewController_iPhone* parentGamePlayViewControllerSuddenDeath =nil;
    
    switch (currentGameMode) {
        case 0:
            parentGamePlayViewControllerThreeLives = (ThreeLivesViewController_iPhone*) parentGamePlayViewController;
            [parentGamePlayViewControllerThreeLives startTheGame];
            break;
        case 1:
            parentGamePlayViewControllerVsTheClock = (VsTheClockViewController_iPhone*) parentGamePlayViewController;
            [parentGamePlayViewControllerVsTheClock startTheGame];
            break;
        case 2:
            parentGamePlayViewControllerSuddenDeath = (SuddenDeathViewController_iPhone*) parentGamePlayViewController;
            [parentGamePlayViewControllerSuddenDeath startTheGame];
            break;
    }
    [self.navigationController popViewControllerAnimated:NO];
}


-(IBAction)goToMainMenu:(id)sender
{
    self.goToMainMenuImage.frame = CGRectOffset(self.goToMainMenuImage.frame, 0, 3);
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, 3);

    [self.navigationController popToRootViewControllerAnimated:NO];
}


-(IBAction)continueGameTouchDown:(id)sender
{
    self.continueImage.frame = CGRectOffset(self.continueImage.frame, 0, -3);
    self.continueLabel.frame = CGRectOffset(self.continueLabel.frame, 0, -3);
}
-(IBAction)restartGameTouchDown:(id)sender
{
    self.restartImage.frame = CGRectOffset(self.restartImage.frame, 0, -3);
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, -3);
}
-(IBAction)goToMainMenuTouchDown:(id)sender
{
    self.goToMainMenuImage.frame = CGRectOffset(self.goToMainMenuImage.frame, 0, -3);
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, -3);
}

-(IBAction)continueGameTouchCancel:(id)sender
{
    self.continueImage.frame = CGRectOffset(self.continueImage.frame, 0, 3);
    self.continueLabel.frame = CGRectOffset(self.continueLabel.frame, 0, 3);
}
-(IBAction)restartGameTouchCancel:(id)sender
{
    self.restartImage.frame = CGRectOffset(self.restartImage.frame, 0, 3);
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, 3);
}
-(IBAction)goToMainMenuTouchCancel:(id)sender
{
    self.goToMainMenuImage.frame = CGRectOffset(self.goToMainMenuImage.frame, 0, 3);
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, 3);
}

-(IBAction)continueGameTouchDragExit:(id)sender
{
    self.continueImage.frame = CGRectOffset(self.continueImage.frame, 0, 3);
    self.continueLabel.frame = CGRectOffset(self.continueLabel.frame, 0, 3);
}
-(IBAction)restartGameTouchDragExit:(id)sender
{
    self.restartImage.frame = CGRectOffset(self.restartImage.frame, 0, 3);
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, 3);
}
-(IBAction)goToMainMenuTouchDragExit:(id)sender
{
    self.goToMainMenuImage.frame = CGRectOffset(self.goToMainMenuImage.frame, 0, 3);
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, 3);
}


#pragma mark -
#pragma mark lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pauseTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:18];
    self.pauseTitleLabel.text = PAUSEVC_NAVIGATIONBAR_TITLE;
    self.restartLabel.text = PAUSEVC_RESTART_TITLE;
    self.continueLabel.text = PAUSEVC_RESUME_TITLE;
    self.goToMainMenuLabel.text = PAUSEVC_GOTOMAINMENU_TITLE;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [continueImage release];
    [continueLabel release];
    [restartImage release];
    [restartLabel release];
    [goToMainMenuImage release];
    [goToMainMenuLabel release];
    [pauseTitleLabel release];
    [super dealloc];
}

@end
