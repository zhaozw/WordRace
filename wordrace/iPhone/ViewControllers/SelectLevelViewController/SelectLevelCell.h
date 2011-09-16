//
//  SelectLevelCell.h
//  wordrace
//
//  Created by Taha Selim Bebek on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectLevelViewController_iPhone;

@interface SelectLevelCell : UITableViewCell

{
    SelectLevelViewController_iPhone* selectLevelTableView;
    UIImageView* backgroundImage;
    UIButton* levelButton;
    UILabel* levelLabel;
    NSInteger level;
    
    UIImageView* padlock;
}
@property(nonatomic,retain) IBOutlet UIImageView* backgroundImage;
@property(nonatomic,retain) IBOutlet UILabel* levelLabel;
@property(nonatomic,retain) IBOutlet UIButton* levelButton;
@property(nonatomic,assign) NSInteger level;
@property(nonatomic,assign) SelectLevelViewController_iPhone* selectLevelTableView;
@property(nonatomic,retain) IBOutlet UIImageView* padlock;
-(IBAction)selectLevelTouchDown:(id)sender;

@end
