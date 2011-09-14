//
//  SelectLevelViewController_iPhone.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectLevelCell;
@interface SelectLevelViewController_iPhone : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UILabel* selectLevelTitle;
    UITableView* selectLevelTableView;
    
    NSInteger currentLevel;
}
@property(nonatomic,retain) IBOutlet UITableView* selectLevelTableView;
@property(nonatomic,retain) IBOutlet UILabel* selectLevelTitle;

-(IBAction)goBack:(id)sender;
-(void)selectLabelCellButtonTouchedDown:(SelectLevelCell*)sender;

@end
