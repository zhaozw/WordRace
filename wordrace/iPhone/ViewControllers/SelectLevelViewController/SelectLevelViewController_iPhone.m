//
//  SelectLevelViewController_iPhone.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectLevelViewController_iPhone.h"
#import "SelectLevelCell.h"

@implementation SelectLevelViewController_iPhone

@synthesize selectLevelTableView;
@synthesize selectLevelTitle;

#pragma mark -
#pragma mark level selected

-(void)selectLabelCellButtonTouchedDown:(SelectLevelCell*)sender
{
    [[NSUserDefaults standardUserDefaults] setInteger:sender.level forKey:@"currentLevel"];
    currentLevel = sender.level;
    
    NSArray* visibleSelectLevelCells = [self.selectLevelTableView visibleCells];
    for (SelectLevelCell* cell in visibleSelectLevelCells) 
    {
        if (![cell isEqual:sender]) {
            if (cell.selected) {
                cell.levelLabel.frame = CGRectOffset(cell.levelLabel.frame, 0, 3);
                [cell setSelected:NO animated:NO];
            }
            cell.levelButton.enabled = YES;
            cell.levelLabel.textColor = [UIColor colorWithRed:0.15 green:0.59 blue:0.88 alpha:1.0];
        }
    }
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    SelectLevelCell* cell = nil;
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"SelectLevelCell" owner:nil options:nil];
    
    for (id object in objects) {
        if ([object isKindOfClass:[SelectLevelCell class]]) {
            cell = (SelectLevelCell*)object;
        }
    }
    
    cell.levelLabel.text = [NSString stringWithFormat:@"Seviye %i",indexPath.row + 1];
    cell.level = indexPath.row;
    cell.selectLevelTableView = self;
    
    if (indexPath.row == currentLevel) 
    {
        [cell setSelected:YES animated:NO];
        [cell.levelButton setEnabled:NO];
        cell.levelLabel.frame = CGRectOffset(cell.levelLabel.frame, 0, -3);
    }
    return cell;
}


#pragma mark -
#pragma mark IBActions


-(IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View LifeCycle

-(void)dealloc
{
    [selectLevelTitle release];
    [selectLevelTableView release];
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
    UIEdgeInsets tableContentInset = UIEdgeInsetsMake(16, 0, 0, 0);
	self.selectLevelTableView.contentInset = tableContentInset;    
    self.selectLevelTitle.font = [UIFont fontWithName:@"Crillee Italic" size:18];
    
    currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLevel"];
    [self.selectLevelTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentLevel inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
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
