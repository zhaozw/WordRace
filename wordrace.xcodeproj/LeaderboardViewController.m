//
//  LeaderboardViewController.m
//  wordrace
//
//  Created by Taha Selim Bebek on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeaderboardViewController.h"
#import "wordraceAppDelegate.h"
#import "LeaderBoardCell.h"
#import "Constants.h"

@interface LeaderboardViewController (P) 
-(BOOL)checkIfAuthenticated;
-(void)registerForNotifications;
-(void)pullLeaderBoard;
@end

@implementation LeaderboardViewController
@synthesize threeLivesButton;
@synthesize vsTheClockButton;
@synthesize suddenDeathButton;
@synthesize titleLabel;
@synthesize aiv;
@synthesize leaderBoardTableView;
@synthesize scoresArray;
@synthesize currentGameMode;
@synthesize players;

#pragma mark -
#pragma mark - Authentication
#pragma mark -

-(void)pullLeaderBoard
{
    self.leaderBoardTableView.alpha = 0;
    [self.aiv startAnimating];
    
    GKLeaderboard *leaderboard = [[[GKLeaderboard alloc] init] autorelease];
    leaderboard.playerScope = GKLeaderboardPlayerScopeGlobal;
    leaderboard.timeScope = GKLeaderboardTimeScopeAllTime;
    leaderboard.range = NSMakeRange(1, 100);
    
    switch (currentGameMode) {
        case 0:
            [leaderboard setCategory:@"vstheclock"];
            break;
        case 1:
            [leaderboard setCategory:@"threelives"];
            break;
        case 2:
            [leaderboard setCategory:@"suddendeath"];
            break;
    }

    
    [leaderboard loadScoresWithCompletionHandler:
     ^(NSArray *scores, NSError *error) {
         if (scores != nil){
             self.scoresArray = scores;
             NSMutableArray* playerIDs = [NSMutableArray array];
             for (GKScore *score in scoresArray){
                 [playerIDs addObject:score.playerID];
             }
             
             [GKPlayer loadPlayersForIdentifiers:playerIDs withCompletionHandler:^(NSArray *playersArray, NSError *error)
              {
                  if (error != nil)
                  {
                      UIAlertView* alert = [[UIAlertView alloc] initWithTitle:ALERTVIEW_ERROR_TITLE message:[error localizedDescription] delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
                      [alert show];
                      [alert release];
                  }
                  if (playersArray != nil)
                  {
                      self.players = playersArray;
                      [self.leaderBoardTableView reloadData];
                      [self.aiv stopAnimating];
                      self.leaderBoardTableView.alpha = 1.0;
                  }
              }];
             
         }
         if (error != nil){
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:ALERTVIEW_ERROR_TITLE message:[error localizedDescription] delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
             [alert show];
             [alert release];
         }
     }];
}

-(BOOL)checkIfAuthenticated
{
    wordraceAppDelegate* appDelegate = (wordraceAppDelegate*)[[UIApplication sharedApplication]delegate];
    return appDelegate.gameCenterAuthenticationComplete;
}

-(void)registerForNotifications
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    [center addObserver:self selector:@selector(localPlayerIsAuthenticated:) name:@"localPlayerIsAuthenticated" object:nil];
    [center addObserver:self selector:@selector(localPlayerAuthenticationFailed:) name:@"localPlayerAuthenticationFailed" object:nil];
}

-(void)localPlayerIsAuthenticated:(NSNotification*)notif
{
    [self pullLeaderBoard]; 
    NSLog(@"%s",__FUNCTION__);
}

-(void)localPlayerAuthenticationFailed:(NSNotification*)notif
{
    NSLog(@"%s",__FUNCTION__);
    [self.aiv stopAnimating];
    NSError* error = [[notif userInfo] valueForKey:@"error"];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:ALERTVIEW_ERROR_TITLE message:[error localizedDescription] delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -


-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)threeLivesModeTouchDown:(id)sender
{
    [self.threeLivesButton setUserInteractionEnabled:NO];
    [self.threeLivesButton setSelected:YES];
    
    [self.vsTheClockButton setUserInteractionEnabled:YES];
    [self.vsTheClockButton setSelected:NO];
    
    [self.suddenDeathButton setUserInteractionEnabled:YES];
    [self.suddenDeathButton setSelected:NO];
    
    currentGameMode = 1;
    
    if (!threeLivesUpdated) 
    {
        [self pullLeaderBoard];
    }
}

-(IBAction)vsTheClockModeTouchDown:(id)sender
{
    [self.threeLivesButton setUserInteractionEnabled:YES];
    [self.threeLivesButton setSelected:NO];
    
    [self.vsTheClockButton setUserInteractionEnabled:NO];
    [self.vsTheClockButton setSelected:YES];
    
    [self.suddenDeathButton setUserInteractionEnabled:YES];
    [self.suddenDeathButton setSelected:NO];
    currentGameMode = 0;
    
    if (!vsTheClockUpdated) 
    {
        [self pullLeaderBoard];
    }
}

-(IBAction)suddenDeathModeTouchDown:(id)sender
{
    [self.threeLivesButton setUserInteractionEnabled:YES];
    [self.threeLivesButton setSelected:NO];
    
    [self.vsTheClockButton setUserInteractionEnabled:YES];
    [self.vsTheClockButton setSelected:NO];
    
    [self.suddenDeathButton setUserInteractionEnabled:NO];
    [self.suddenDeathButton setSelected:YES];
    currentGameMode = 2;
    
    if (!suddenDeathUpdated) 
    {
        [self pullLeaderBoard];
    }
}


#pragma mark -
#pragma mark - lifecycle
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentGameMode = 0;
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
    self.titleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:18];
    self.titleLabel.text = LEADERBOARD_NAVIGATIONBAR_TITLE;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL gameCenterAPIAvailable = [defaults boolForKey:@"gameCenterAPIAvailable"]; 
    
    if (gameCenterAPIAvailable) 
    {
        BOOL authenticated = [self checkIfAuthenticated];
        
        if (authenticated) 
        {
            [self pullLeaderBoard]; 
        }
        else
        {
            [self registerForNotifications];
        }
    }
    else
    {
        [self.aiv stopAnimating];
        NSString* errorMessage = [defaults valueForKey:@"gameCenterNotAvailableReason"];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:ALERTVIEW_ERROR_TITLE message:errorMessage delegate:nil cancelButtonTitle:ALERTVIEW_CANCELBUTTON_TITLE otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    switch (currentGameMode) 
    {
        case 0:
            [self.vsTheClockButton setSelected:YES];
            break;
        case 1:
            [self.threeLivesButton setSelected:YES];
            break;
        case 2:
            [self.suddenDeathButton setSelected:YES];
            break;
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

- (void)dealloc
{
    [players release];
    [scoresArray release];
    [leaderBoardTableView release];
    [aiv release];
    [titleLabel release];
    [threeLivesButton release];
    [vsTheClockButton release];
    [suddenDeathButton release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark tableview delegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [scoresArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeaderBoardCell* cell = nil;
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"LeaderBoardCell" owner:nil options:nil];
    
    for (id object in objects) {
        if ([object isKindOfClass:[LeaderBoardCell class]]) {
            cell = (LeaderBoardCell*)object;
        }
    }
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    GKScore *score = [scoresArray objectAtIndex:indexPath.row];
    GKPlayer* player =[players objectAtIndex:indexPath.row];
    cell.indexLabel.text = [NSString stringWithFormat:@"%i",score.rank];
    //cell.indexLabel.text = @"100";
    cell.aliasLabel.text = player.alias;
    cell.scoreLabel.text = [NSString stringWithFormat:@"%i",(NSInteger)score.value];
    
    if ([localPlayer.playerID isEqualToString:player.playerID]) {
        cell.indexLabel.textColor = [UIColor greenColor];
        cell.aliasLabel.textColor = [UIColor greenColor];
        cell.scoreLabel.textColor = [UIColor greenColor];
    }
	return cell;

}
@end
