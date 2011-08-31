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

@implementation WelcomeViewController_iPhone
@synthesize managedObjectContext;


#pragma mark -
#pragma mark IBActions

-(IBAction)playTheGame:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
    GameModesViewController_iPhone* gameModesViewController = [[GameModesViewController_iPhone alloc] initWithNibName:@"GameModesViewController_iPhone" bundle:nil];
    gameModesViewController.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:gameModesViewController animated:NO];
    [gameModesViewController release];
}
-(IBAction)selectLevel:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
    SelectLevelViewController_iPhone* selectLevelViewController = [[SelectLevelViewController_iPhone alloc] initWithNibName:@"SelectLevelViewController_iPhone" bundle:nil];
    [self.navigationController pushViewController:selectLevelViewController animated:NO];
    [selectLevelViewController release];
}
-(IBAction)showScores:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
}
-(IBAction)showInfo:(id)sender
{
    //NSLog(@"%s",__FUNCTION__);
}


#pragma mark -
#pragma mark View Lifecycle

- (void)dealloc
{
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
    // Do any additional setup after loading the view from its nib.
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
