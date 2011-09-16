//
//  LeaderBoardCell.m
//  wordrace
//
//  Created by Taha Selim Bebek on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeaderBoardCell.h"

@implementation LeaderBoardCell
@synthesize indexLabel;
@synthesize aliasLabel;
@synthesize scoreLabel;

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

    // Configure the view for the selected state
}

- (void)dealloc
{
    [indexLabel release];
    [aliasLabel release];
    [scoreLabel release];
    
    [super dealloc];
}



@end
