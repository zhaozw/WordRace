//
//  PauseViewController.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PauseViewController : UIViewController
{
    UIViewController* parentGamePlayViewController;
    
    NSUInteger currentGameMode;
    NSUInteger currentLevel;

}
@property(nonatomic,assign) UIViewController* parentGamePlayViewController;
@property(nonatomic,assign) NSUInteger currentGameMode;
@property(nonatomic,assign) NSUInteger currentLevel;

-(IBAction)continueGame:(id)sender;
-(IBAction)restartGame:(id)sender;
-(IBAction)goToMainMenu:(id)sender;
@end
