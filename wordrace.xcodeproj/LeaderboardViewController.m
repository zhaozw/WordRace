//
//  LeaderboardViewController.m
//  wordrace
//
//  Created by Taha Selim Bebek on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeaderboardViewController.h"

@implementation LeaderboardViewController
@synthesize threeLivesButton;
@synthesize vsTheClockButton;
@synthesize suddenDeathButton;
@synthesize titleLabel;


#pragma mark -
#pragma mark - IBActions
#pragma mark -


-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)threeLivesModeTouchDown:(id)sender
{
    
}

-(IBAction)vsTheClockModeTouchDown:(id)sender
{
    
}

-(IBAction)suddenDeathModeTouchDown:(id)sender
{
    
}


#pragma mark -
#pragma mark - lifecycle
#pragma mark -

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
    self.titleLabel.font = [UIFont fontWithName:@"Crillee Italic" size:18];
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
    [titleLabel release];
    [threeLivesButton release];
    [vsTheClockButton release];
    [suddenDeathButton release];
    
    [super dealloc];
}



@end
