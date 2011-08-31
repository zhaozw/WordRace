//
//  SelectLevelViewController_iPhone.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLevelViewController_iPhone : UIViewController
{
    UILabel* beginnerThumbsUpLabel;
    UILabel* intermediateThumbsUpLabel;
    UILabel* advancedThumbsUpLabel;
}
@property(nonatomic,retain) IBOutlet UILabel* beginnerThumbsUpLabel;
@property(nonatomic,retain) IBOutlet UILabel* intermediateThumbsUpLabel;
@property(nonatomic,retain) IBOutlet UILabel* advancedThumbsUpLabel;

-(IBAction)goBack:(id)sender;
-(IBAction)selectBeginnerLevel:(id)sender;
-(IBAction)selectIntermediateLevel:(id)sender;
-(IBAction)selectAdvancedLevel:(id)sender;

@end
