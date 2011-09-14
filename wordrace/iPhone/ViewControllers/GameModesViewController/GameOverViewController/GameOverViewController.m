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
@synthesize nameTitleLabel;
@synthesize scoreTitleLabel;
@synthesize highScoreTitleLabel;

@synthesize name;
@synthesize score;
@synthesize highScore;
@synthesize gameOverTitleLabel;

@synthesize restartLabel;
@synthesize scoresLabel;
@synthesize postToFacebookLabel;
@synthesize postToFacebookImage;
@synthesize postToTwitterLabel;
@synthesize postToTwitterImage;
@synthesize goToMainMenuLabel;
@synthesize moreGamesLabel;

#pragma mark -
#pragma mark IBActions

-(IBAction)restartGame:(id)sender
{
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
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, 3);

    [self.navigationController popToRootViewControllerAnimated:NO];
}


-(IBAction)postToFacebook:(id)sender
{
    self.postToFacebookImage.frame = CGRectOffset(self.postToFacebookImage.frame, 0, 3);
    self.postToFacebookLabel.frame = CGRectOffset(self.postToFacebookLabel.frame, 0, 3);
}

-(IBAction)postToTwitter:(id)sender
{
    self.postToTwitterImage.frame = CGRectOffset(self.postToTwitterImage.frame, 0, 3);
    self.postToTwitterLabel.frame = CGRectOffset(self.postToTwitterLabel.frame, 0, 3);
}

-(IBAction)showScores:(id)sender
{
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
}

-(IBAction)showMoreGames:(id)sender
{
    self.moreGamesLabel.frame = CGRectOffset(self.moreGamesLabel.frame, 0, 3);
}

-(IBAction)restartGameTouchDown:(id)sender
{
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, -3);
}
-(IBAction)goToMainMenuTouchDown:(id)sender
{
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, -3);
}
-(IBAction)postToFacebookTouchDown:(id)sender
{
    self.postToFacebookImage.frame = CGRectOffset(self.postToFacebookImage.frame, 0, -3);
    self.postToFacebookLabel.frame = CGRectOffset(self.postToFacebookLabel.frame, 0, -3);
}
-(IBAction)postToTwitterTouchDown:(id)sender
{
    self.postToTwitterImage.frame = CGRectOffset(self.postToTwitterImage.frame, 0, -3);
    self.postToTwitterLabel.frame = CGRectOffset(self.postToTwitterLabel.frame, 0, -3);
}
-(IBAction)showScoresTouchDown:(id)sender
{
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, -3);
}
-(IBAction)showMoreGamesTouchDown:(id)sender
{
    self.moreGamesLabel.frame = CGRectOffset(self.moreGamesLabel.frame, 0, -3);
}

-(IBAction)restartGameTouchCancel:(id)sender
{
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, 3);
}
-(IBAction)goToMainMenuTouchCancel:(id)sender
{
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, 3);
}
-(IBAction)postToFacebookTouchCancel:(id)sender
{
    self.postToFacebookImage.frame = CGRectOffset(self.postToFacebookImage.frame, 0, 3);
    self.postToFacebookLabel.frame = CGRectOffset(self.postToFacebookLabel.frame, 0, 3);
}
-(IBAction)postToTwitterTouchCancel:(id)sender
{
    self.postToTwitterImage.frame = CGRectOffset(self.postToTwitterImage.frame, 0, 3);
    self.postToTwitterLabel.frame = CGRectOffset(self.postToTwitterLabel.frame, 0, 3);
}
-(IBAction)showScoresTouchCancel:(id)sender
{
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
}
-(IBAction)showMoreGamesTouchCancel:(id)sender
{
    self.moreGamesLabel.frame = CGRectOffset(self.moreGamesLabel.frame, 0, 3);
}

-(IBAction)restartGameTouchDragExit:(id)sender
{
    self.restartLabel.frame = CGRectOffset(self.restartLabel.frame, 0, 3);
}
-(IBAction)goToMainMenuTouchDragExit:(id)sender
{
    self.goToMainMenuLabel.frame = CGRectOffset(self.goToMainMenuLabel.frame, 0, 3);
}
-(IBAction)postToFacebookTouchDragExit:(id)sender
{
    self.postToFacebookImage.frame = CGRectOffset(self.postToFacebookImage.frame, 0, 3);
    self.postToFacebookLabel.frame = CGRectOffset(self.postToFacebookLabel.frame, 0, 3);
}
-(IBAction)postToTwitterTouchDragExit:(id)sender
{
    self.postToTwitterImage.frame = CGRectOffset(self.postToTwitterImage.frame, 0, 3);
    self.postToTwitterLabel.frame = CGRectOffset(self.postToTwitterLabel.frame, 0, 3);
}
-(IBAction)showScoresTouchDragExit:(id)sender
{
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
}
-(IBAction)showMoreGamesTouchDragExit:(id)sender
{
    self.moreGamesLabel.frame = CGRectOffset(self.moreGamesLabel.frame, 0, 3);
}


#pragma mark -
#pragma mark lifecycle

-(void)dealloc
{
    [gameOverTitleLabel release];
    [nameLabel release];
    [scoreLabel release];
    [highScoreLabel release];
    [nameTitleLabel release];
    [scoreTitleLabel release];
    [highScoreTitleLabel release];
    [name release];
    
    [restartLabel release];
    [scoresLabel release];
    [postToFacebookLabel release];
    [postToFacebookImage release];
    [postToTwitterLabel release];
    [postToTwitterImage release];
    [goToMainMenuLabel release];
    [moreGamesLabel release];

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
    self.gameOverTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:18];
    
    self.nameLabel.font = [UIFont fontWithName:@"Crillee Italic" size:20];
    self.scoreLabel.font = [UIFont fontWithName:@"Crillee Italic" size:20];
    self.highScoreLabel.font = [UIFont fontWithName:@"Crillee Italic" size:20];
    self.nameTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:14];
    self.scoreTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:14];
    self.highScoreTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:14];

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
