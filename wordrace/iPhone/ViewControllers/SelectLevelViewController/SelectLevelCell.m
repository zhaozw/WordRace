//
//  SelectLevelCell.m
//  ;
//
//  Created by Taha Selim Bebek on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectLevelCell.h"
#import "SelectLevelViewController_iPhone.h"

@implementation SelectLevelCell
@synthesize backgroundImage;
@synthesize levelLabel;
@synthesize levelButton;
@synthesize level;
@synthesize selectLevelTableView;
@synthesize padlock;

#pragma mark -
#pragma mark IBActions


-(IBAction)selectLevelTouchDown:(id)sender
{
    self.levelLabel.frame = CGRectOffset(self.levelLabel.frame, 0, -3);
    [self setSelected:YES animated:NO];
    [self.levelButton setEnabled:NO];
    [self.selectLevelTableView selectLabelCellButtonTouchedDown:self];
}

#pragma mark -
#pragma mark lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) 
    {
        self.levelLabel.textColor = [UIColor redColor];
    }
}

-(void)dealloc
{
    [padlock release];
    [levelButton release];
    [levelLabel release];
    [backgroundImage release];
    [super dealloc];
}
@end
