//
//  LeaderboardViewController.h
//  wordrace
//
//  Created by Taha Selim Bebek on 9/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderboardViewController : UIViewController
{
    UIButton* threeLivesButton;
    UIButton* vsTheClockButton;
    UIButton* suddenDeathButton;
    
    UILabel* titleLabel;
}

@property(nonatomic,retain) IBOutlet UIButton* threeLivesButton;
@property(nonatomic,retain) IBOutlet UIButton* vsTheClockButton;
@property(nonatomic,retain) IBOutlet UIButton* suddenDeathButton;
@property(nonatomic,retain) IBOutlet UILabel* titleLabel;

-(IBAction)goBack:(id)sender;
-(IBAction)threeLivesModeTouchDown:(id)sender;
-(IBAction)vsTheClockModeTouchDown:(id)sender;
-(IBAction)suddenDeathModeTouchDown:(id)sender;

@end
