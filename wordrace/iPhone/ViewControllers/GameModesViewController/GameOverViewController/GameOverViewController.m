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
#import "wordraceAppDelegate.h"
#import "SA_OAuthTwitterEngine.h"
#import "LeaderboardViewController.h"
#import "Constants.h"

@implementation GameOverViewController
@synthesize didBrakeHighScore;

#pragma mark -
#pragma mark facebook
#pragma mark -

-(void)postToFacebookWall
{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   FACEBOOK_APPID, @"app_id",
                                   APP_LINK, @"link",
                                   APP_PICTURE_LINK, @"picture",
                                   [NSString stringWithFormat:FACEBOOKMESSAGE,self.gameMode,self.score,self.currentLevel +1], @"name",
                                   FACEBOOKDESCRIPTION, @"description",
                                   nil];
    [facebook dialog:@"feed" andParams:params andDelegate:self];
}

-(IBAction)postToFacebook:(id)sender
{
    self.postToFacebookImage.frame = CGRectOffset(self.postToFacebookImage.frame, 0, 3);
    self.postToFacebookLabel.frame = CGRectOffset(self.postToFacebookLabel.frame, 0, 3);
    
    self.facebook = [[[Facebook alloc] initWithAppId:FACEBOOK_APPID andDelegate:self] autorelease];
    wordraceAppDelegate* appDelegate = (wordraceAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.facebook = self.facebook;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid]) {
        NSArray* permissions =  [NSArray arrayWithObjects:@"publish_stream", @"offline_access",nil];
        [facebook authorize:permissions];
    }
    else
    {
        [self postToFacebookWall];
    }
}

- (void)fbDidLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self postToFacebookWall];
}

- (void)dialogDidComplete:(FBDialog *)dialog
{
    /*
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:GAMEOVER_SHARED_ON_FACEBOOK_ALERT_MESSAGE message:nil delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
    [alert show];
    [alert release];
     */
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:ALERTVIEW_ERROR_TITLE message:[error localizedDescription] delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma mark twitter
#pragma mark -

-(void)postToTwitterWall
{
    NSString* tweet = [NSString stringWithFormat:TWITTERMESSAGE,self.gameMode,self.score,self.currentLevel +1,APP_LINK];
    [twitterEngine sendUpdate:tweet];
}

-(IBAction)postToTwitter:(id)sender
{
    self.postToTwitterImage.frame = CGRectOffset(self.postToTwitterImage.frame, 0, 3);
    self.postToTwitterLabel.frame = CGRectOffset(self.postToTwitterLabel.frame, 0, 3);
    
	self.twitterEngine = [[[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self] autorelease];
	twitterEngine.consumerKey = TWITTER_CONSUMERKEY;
	twitterEngine.consumerSecret = TWITTER_CONSUMERSECRET;
	
    if ([twitterEngine isAuthorized]) {
        [self postToTwitterWall];
    }
    else
    {
        UIViewController* controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:twitterEngine delegate: self];
        [self presentModalViewController: controller animated: YES];
    }
}


#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
    [self postToTwitterWall];
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller 
{

}

#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier 
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:GAMEOVER_SHARED_ON_TWITTER_ALERT_MESSAGE message:nil delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error 
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:ALERTVIEW_ERROR_TITLE message:[error localizedDescription] delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma mark game center
#pragma mark -

-(BOOL)reportscore
{
    __block BOOL reportResult = NO;
    GKScore* playerScore = nil;
    
    switch (currentGameMode) {
        case 0:
            playerScore = [[[GKScore alloc]
                            initWithCategory:LEADERBOARD_THREELIVES_ID] autorelease];            
            break;
        case 1:
            playerScore = [[[GKScore alloc]
                            initWithCategory:LEADERBOARD_VSTHECLOCK_ID] autorelease];            
            break;
        case 2:
            playerScore = [[[GKScore alloc]
                            initWithCategory::LEADERBOARD_SUDDENDEATH_ID] autorelease];            
            break;
    }
    
    playerScore.value = (int64_t)self.highScore;
    
    [playerScore reportScoreWithCompletionHandler:^(NSError *error) {
        if (error == nil){
            reportResult = YES;
        } else {
        }
    }];
    return reportResult;
}


#pragma mark -
#pragma mark lifecycle
#pragma mark -

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
    
    [facebook release];
    [twitterEngine release];
    [gameMode release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreLabel.text = [NSString stringWithFormat:@"%i",self.score];
    self.highScoreLabel.text = [NSString stringWithFormat:@"%i",self.highScore];
    self.gameOverTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:18];
    self.gameOverTitleLabel.text = GAMEOVER_NAVIGATIONBAR_TITLE;
    
    self.nameLabel.font = [UIFont fontWithName:@"Crillee Italic" size:20];
    self.scoreLabel.font = [UIFont fontWithName:@"Crillee Italic" size:20];
    self.highScoreLabel.font = [UIFont fontWithName:@"Crillee Italic" size:20];
    
    self.nameTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:14];
    self.scoreTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:14];
    self.highScoreTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:14];
    self.nameTitleLabel.text = GAMEOVER_NAMELABEL_TITLE;
    self.scoreTitleLabel.text = GAMEOVER_SCORELABEL_TITLE;
    self.highScoreTitleLabel.text = GAMEOVER_HIGHSCORELABEL_TITLE;
    
    self.restartLabel.text = GAMEOVER_RESTARTLABEL_TITLE;
    self.scoresLabel.text = GAMEOVER_SCORESLABEL_TITLE;
    self.goToMainMenuLabel.text = GAMEOVER_GOTOMAINMENULABEL_TITLE;
    self.moreGamesLabel.text = GAMEOVER_MOREGAMESLABEL_TITLE;
    
    GKLocalPlayer* player = [GKLocalPlayer localPlayer];
    self.nameLabel.text = player.alias;
    
    if (self.didBrakeHighScore) {
        [self reportscore];
    }
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

#pragma mark -
#pragma mark IBActions
#pragma mark -

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

-(IBAction)showScores:(id)sender
{
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
    
    LeaderboardViewController* leaderboardViewController = [[LeaderboardViewController alloc] initWithNibName:@"LeaderboardViewController" bundle:nil];
    
    switch (currentGameMode) 
    {
        case 0:
            leaderboardViewController.currentGameMode = 1;
            break;
        case 1:
            leaderboardViewController.currentGameMode = 0;
            break;
        case 2:
            leaderboardViewController.currentGameMode = 2;
            break;
    }

    [self.navigationController pushViewController:leaderboardViewController animated:YES];
    [leaderboardViewController release]; 
}

-(IBAction)showMoreGames:(id)sender
{
    self.moreGamesLabel.frame = CGRectOffset(self.moreGamesLabel.frame, 0, 3);
    
    NSString *search = @"taha selim bebek";  
    NSString *sstring = [NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZSearch.woa/wa/search?WOURLEncoding=ISO8859_1&lang=1&output=lm&country=US&term=%@&media=software", [search stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];  
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sstring]];  
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
#pragma mark synthesizers
#pragma mark -

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
@synthesize facebook;
@synthesize twitterEngine;
@synthesize gameMode;


@end
