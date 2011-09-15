//
//  GameModesViewController_iPhone.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameModesViewController_iPhone.h"
#import "ThreeLivesViewController_iPhone.h"
#import "VsTheClockViewController_iPhone.h"
#import "SuddenDeathViewController_iPhone.h"

@implementation GameModesViewController_iPhone
@synthesize managedObjectContext;
@synthesize gameModesTitleLabel;
@synthesize threeLivesLabel;
@synthesize vsTheClockLabel;
@synthesize suddenDeathLabel;

#pragma mark -
#pragma mark IBActions

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)playThreeLivesMode:(id)sender
{
    self.threeLivesLabel.frame = CGRectOffset(self.threeLivesLabel.frame, 0, 3);

    ThreeLivesViewController_iPhone* threeLivesViewController_iPhone = [[ThreeLivesViewController_iPhone alloc]initWithNibName:@"ThreeLivesViewController_iPhone" bundle:nil];
    threeLivesViewController_iPhone.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:threeLivesViewController_iPhone animated:NO];
    [threeLivesViewController_iPhone release];
}
-(IBAction)playVsTheClockMode:(id)sender
{
    self.vsTheClockLabel.frame = CGRectOffset(self.vsTheClockLabel.frame, 0, 3);

    VsTheClockViewController_iPhone* vsTheClockViewController_iPhone = [[VsTheClockViewController_iPhone alloc]initWithNibName:@"VsTheClockViewController_iPhone" bundle:nil];
    vsTheClockViewController_iPhone.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:vsTheClockViewController_iPhone animated:NO];
    [vsTheClockViewController_iPhone release];

}
-(IBAction)playSuddenDeathMode:(id)sender
{
    self.suddenDeathLabel.frame = CGRectOffset(self.suddenDeathLabel.frame, 0, 3);

    SuddenDeathViewController_iPhone* suddenDeathViewController_iPhone = [[SuddenDeathViewController_iPhone alloc]initWithNibName:@"SuddenDeathViewController_iPhone" bundle:nil];
    suddenDeathViewController_iPhone.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:suddenDeathViewController_iPhone animated:NO];
    [suddenDeathViewController_iPhone release];

}

-(IBAction)playThreeLivesModeTouchDown:(id)sender
{
    self.threeLivesLabel.frame = CGRectOffset(self.threeLivesLabel.frame, 0, -3);
}
-(IBAction)playVsTheClockModeTouchDown:(id)sender
{
    self.vsTheClockLabel.frame = CGRectOffset(self.vsTheClockLabel.frame, 0, -3);
}
-(IBAction)playSuddenDeathModeTouchDown:(id)sender
{
    self.suddenDeathLabel.frame = CGRectOffset(self.suddenDeathLabel.frame, 0, -3);
}

-(IBAction)playThreeLivesModeTouchCancel:(id)sender
{
    self.threeLivesLabel.frame = CGRectOffset(self.threeLivesLabel.frame, 0, 3);
}
-(IBAction)playVsTheClockModeTouchCancel:(id)sender
{
    self.vsTheClockLabel.frame = CGRectOffset(self.vsTheClockLabel.frame, 0, 3);
}
-(IBAction)playSuddenDeathModeTouchCancel:(id)sender
{
    self.suddenDeathLabel.frame = CGRectOffset(self.suddenDeathLabel.frame, 0, 3);
}

-(IBAction)playThreeLivesModeTouchDragExit:(id)sender
{
    self.threeLivesLabel.frame = CGRectOffset(self.threeLivesLabel.frame, 0, 3);
}
-(IBAction)playVsTheClockModeTouchDragExit:(id)sender
{
    self.vsTheClockLabel.frame = CGRectOffset(self.vsTheClockLabel.frame, 0, 3);
}
-(IBAction)playSuddenDeathModeTouchDragExit:(id)sender
{
    self.suddenDeathLabel.frame = CGRectOffset(self.suddenDeathLabel.frame, 0, 3);
}

#pragma mark -
#pragma mark View LifeCycle

- (void)dealloc
{
    [threeLivesLabel release];
    [vsTheClockLabel release];
    [suddenDeathLabel release];
    [gameModesTitleLabel release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gameModesTitleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:18];
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
