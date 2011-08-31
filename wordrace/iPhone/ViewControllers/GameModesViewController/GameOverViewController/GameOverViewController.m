//
//  GameOverViewController.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameOverViewController.h"
#import "ThreeLivesViewController_iPhone.h"
#import "VsTheClockViewController_iPhone.h"
#import "SuddenDeathViewController_iPhone.h"

@implementation GameOverViewController
@synthesize parentGamePlayViewController;
@synthesize currentGameMode;
@synthesize currentLevel;
@synthesize nameLabel;
@synthesize scoreLabel;
@synthesize highScoreLabel;
@synthesize name;
@synthesize score;
@synthesize highScore;

#pragma mark -
#pragma mark IBActions

-(IBAction)restartGame:(id)sender
{
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
    [self.navigationController popToRootViewControllerAnimated:NO];
}


-(IBAction)postToFacebook:(id)sender
{
    
}

-(IBAction)postToTwitter:(id)sender
{
    
}

-(IBAction)showScores:(id)sender
{
    
}

-(IBAction)showMoreGames:(id)sender
{
    
}

#pragma mark -
#pragma mark lifecycle

-(void)dealloc
{
    [nameLabel release];
    [scoreLabel release];
    [highScoreLabel release];
    [name release];
    [super dealloc];
    
}
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
    self.scoreLabel.text = [NSString stringWithFormat:@"%i",self.score];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%i",self.highScore];

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

@end
