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

#pragma mark -
#pragma mark IBActions

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)playThreeLivesMode:(id)sender
{
    ThreeLivesViewController_iPhone* threeLivesViewController_iPhone = [[ThreeLivesViewController_iPhone alloc]initWithNibName:@"ThreeLivesViewController_iPhone" bundle:nil];
    threeLivesViewController_iPhone.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:threeLivesViewController_iPhone animated:NO];
    [threeLivesViewController_iPhone release];
}
-(IBAction)playVsTheClockMode:(id)sender
{
    VsTheClockViewController_iPhone* vsTheClockViewController_iPhone = [[VsTheClockViewController_iPhone alloc]initWithNibName:@"VsTheClockViewController_iPhone" bundle:nil];
    vsTheClockViewController_iPhone.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:vsTheClockViewController_iPhone animated:NO];
    [vsTheClockViewController_iPhone release];

}
-(IBAction)playSuddenDeathMode:(id)sender
{
    SuddenDeathViewController_iPhone* suddenDeathViewController_iPhone = [[SuddenDeathViewController_iPhone alloc]initWithNibName:@"SuddenDeathViewController_iPhone" bundle:nil];
    suddenDeathViewController_iPhone.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:suddenDeathViewController_iPhone animated:NO];
    [suddenDeathViewController_iPhone release];

}

#pragma mark -
#pragma mark View LifeCycle

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
