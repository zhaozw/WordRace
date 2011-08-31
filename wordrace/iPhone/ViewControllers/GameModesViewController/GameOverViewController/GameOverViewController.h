//
//  GameOverViewController.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameOverViewController : UIViewController
{
    UILabel* nameLabel;
    UILabel* scoreLabel;
    UILabel* highScoreLabel;
    
    NSString* name;
    NSUInteger score;
    NSUInteger highScore;
    
    UIViewController* parentGamePlayViewController;
    NSUInteger currentGameMode;
    NSUInteger currentLevel;
}

@property(nonatomic,assign) UIViewController* parentGamePlayViewController;
@property(nonatomic,assign) NSUInteger currentGameMode;
@property(nonatomic,assign) NSUInteger currentLevel;
@property(nonatomic,retain) IBOutlet UILabel* nameLabel;
@property(nonatomic,retain) IBOutlet UILabel* scoreLabel;
@property(nonatomic,retain) IBOutlet UILabel* highScoreLabel;

@property(nonatomic,retain) NSString* name;
@property(nonatomic,assign) NSUInteger score;
@property(nonatomic,assign) NSUInteger highScore;

-(IBAction)restartGame:(id)sender;
-(IBAction)goToMainMenu:(id)sender;
-(IBAction)postToFacebook:(id)sender;
-(IBAction)postToTwitter:(id)sender;
-(IBAction)showScores:(id)sender;
-(IBAction)showMoreGames:(id)sender;

@end
