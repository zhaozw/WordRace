//
//  LeaderBoardCell.h
//  wordrace
//
//  Created by Taha Selim Bebek on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardCell : UITableViewCell
{
    UILabel* indexLabel;
    UILabel* aliasLabel;
    UILabel* scoreLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *indexLabel;
@property (nonatomic, retain) IBOutlet UILabel *aliasLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;

@end
