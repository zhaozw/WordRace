//
//  SelectLevelViewController_iPhone.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectLevelViewController_iPhone.h"

@implementation SelectLevelViewController_iPhone

@synthesize beginnerThumbsUpLabel;
@synthesize intermediateThumbsUpLabel;
@synthesize advancedThumbsUpLabel;


#pragma mark -
#pragma mark IBActions

-(void)switchThumbsUp
{
    NSInteger currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLevel"];
    
    if (currentLevel == 0) {
        currentLevel = 1;
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"currentLevel"];
    }
    
    switch (currentLevel) {
        case 1:
            beginnerThumbsUpLabel.alpha = 1.0;
            intermediateThumbsUpLabel.alpha = 0.0;
            advancedThumbsUpLabel.alpha = 0.0;
            break;
        case 2:
            beginnerThumbsUpLabel.alpha = 0.0;
            intermediateThumbsUpLabel.alpha = 1.0;
            advancedThumbsUpLabel.alpha = 0.0;
            break;
        case 3:
            beginnerThumbsUpLabel.alpha = 0.0;
            intermediateThumbsUpLabel.alpha = 0.0;
            advancedThumbsUpLabel.alpha = 1.0;
            break;
    }    
}

-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)selectBeginnerLevel:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"currentLevel"];
    [self switchThumbsUp];
}
-(IBAction)selectIntermediateLevel:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"currentLevel"];
    [self switchThumbsUp];
}
-(IBAction)selectAdvancedLevel:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"currentLevel"];
    [self switchThumbsUp];
}


#pragma mark -
#pragma mark View LifeCycle

-(void)dealloc
{
    [beginnerThumbsUpLabel release];
    [intermediateThumbsUpLabel release];
    [advancedThumbsUpLabel release];
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
    [self switchThumbsUp];
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
