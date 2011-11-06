//
//  WelcomeViewController_iPhone.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController_iPhone.h"
#import "GameModesViewController_iPhone.h"
#import "SelectLevelViewController_iPhone.h"
#import "LeaderboardViewController.h"
#import "Constants.h"

@implementation WelcomeViewController_iPhone
@synthesize managedObjectContext;
@synthesize titleLabel;
@synthesize playLabel;
@synthesize levelLabel;
@synthesize scoresLabel;
@synthesize playImage;
@synthesize scoresImage;
@synthesize levelImage;

@synthesize landscapeViewForIPad;
@synthesize portraitViewForIPad;

#pragma mark-
#pragma mark commenting

- (void)checkCommentCount
{
	BOOL commented = [[NSUserDefaults standardUserDefaults] boolForKey:@"commented"];
	if (!commented) {
		NSInteger launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"launchCount"];
		if (launchCount < 5) {
			launchCount = launchCount + 1;
			[[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:@"launchCount"];
		}
		else {
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"commented"];
			commenting = YES;
			UIAlertView *buttonAlert = [ [UIAlertView alloc] initWithTitle: @"Destek Olun!" message: @"Eğer uygulamayı beğendiyseniz App Store'da 5 yıldız verebilirsiniz. Teşekkürler!" 
																  delegate: self cancelButtonTitle: @"Daha Sonra" otherButtonTitles: @"Yıldız Ver", nil]; 
			[buttonAlert show] ; 
			[buttonAlert release]; 
		}
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	
	if (commenting) {
		commenting = NO;
		if (buttonIndex == 1) { 
			NSURL*url = [NSURL URLWithString:@"http://itunes.apple.com/tr/app/id465683163?mt=8"]; 
			[[UIApplication sharedApplication] openURL: url]; 
		} 
	}
}

#pragma mark -
#pragma mark IBActions

-(IBAction)playTheGame:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
    self.playImage.frame = CGRectOffset(self.playImage.frame, 0, 3);
    self.playLabel.frame = CGRectOffset(self.playLabel.frame, 0, 3);

    GameModesViewController_iPhone* gameModesViewController = [[GameModesViewController_iPhone alloc] initWithNibName:@"GameModesViewController_iPhone" bundle:nil];
    gameModesViewController.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:gameModesViewController animated:YES];
    [gameModesViewController release];
}
-(IBAction)selectLevel:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
    self.levelImage.frame = CGRectOffset(self.levelImage.frame, 0, 3);
    self.levelLabel.frame = CGRectOffset(self.levelLabel.frame, 0, 3);
    
    SelectLevelViewController_iPhone* selectLevelViewController = [[SelectLevelViewController_iPhone alloc] initWithNibName:@"SelectLevelViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:selectLevelViewController animated:YES];
    [selectLevelViewController release];
}
-(IBAction)showScores:(id)sender
{
    self.scoresImage.frame = CGRectOffset(self.scoresImage.frame, 0, 3);
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
        
    LeaderboardViewController* leaderboardViewController = [[LeaderboardViewController alloc] initWithNibName:@"LeaderboardViewController" bundle:nil];
    [self.navigationController pushViewController:leaderboardViewController animated:YES];
    [leaderboardViewController release]; 
}

-(IBAction)showInfo:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
}

-(IBAction)playTheGameTouchDown:(id)sender
{
    self.playImage.frame = CGRectOffset(self.playImage.frame, 0, -3);
    self.playLabel.frame = CGRectOffset(self.playLabel.frame, 0, -3);
}

-(IBAction)selectLevelTouchDown:(id)sender
{
    self.levelImage.frame = CGRectOffset(self.levelImage.frame, 0, -3);
    self.levelLabel.frame = CGRectOffset(self.levelLabel.frame, 0, -3);
}
-(IBAction)showScoresTouchDown:(id)sender
{
    self.scoresImage.frame = CGRectOffset(self.scoresImage.frame, 0, -3);
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, -3);
}

-(IBAction)playTheGameTouchCancel:(id)sender
{
    self.playImage.frame = CGRectOffset(self.playImage.frame, 0, 3);
    self.playLabel.frame = CGRectOffset(self.playLabel.frame, 0, 3);
}

-(IBAction)selectLevelTouchCancel:(id)sender
{
    self.levelImage.frame = CGRectOffset(self.levelImage.frame, 0, 3);
    self.levelLabel.frame = CGRectOffset(self.levelLabel.frame, 0, 3);
}
-(IBAction)showScoresTouchCancel:(id)sender
{
    self.scoresImage.frame = CGRectOffset(self.scoresImage.frame, 0, 3);
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
}

-(IBAction)playTheGameTouchDragExit:(id)sender
{
    self.playImage.frame = CGRectOffset(self.playImage.frame, 0, 3);
    self.playLabel.frame = CGRectOffset(self.playLabel.frame, 0, 3);
}

-(IBAction)selectLevelTouchDragExit:(id)sender
{
    self.levelImage.frame = CGRectOffset(self.levelImage.frame, 0, 3);
    self.levelLabel.frame = CGRectOffset(self.levelLabel.frame, 0, 3);
}
-(IBAction)showScoresTouchDragExit:(id)sender
{
    self.scoresImage.frame = CGRectOffset(self.scoresImage.frame, 0, 3);
    self.scoresLabel.frame = CGRectOffset(self.scoresLabel.frame, 0, 3);
}


#pragma mark -
#pragma mark View Lifecycle

- (void)dealloc
{
    [landscapeViewForIPad release];
    [portraitViewForIPad release];
    [playImage release];
    [levelImage release];
    [scoresImage release];
    [playLabel release];
    [levelLabel release];
    [scoresLabel release];
    [titleLabel release];
    [managedObjectContext release];
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
    //self.titleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:26];
    [self checkCommentCount];
    self.titleLabel.text = WELCOMEVC_GAMENAME;
    self.playLabel.text = WELCOMEVC_PLAYBUTTON_TITLE;
    self.levelLabel.text = WELCOMEVC_LEVELBUTTON_TITLE;
    self.scoresLabel.text = WELCOMEVC_SCORESBUTTON_TITLE;
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
