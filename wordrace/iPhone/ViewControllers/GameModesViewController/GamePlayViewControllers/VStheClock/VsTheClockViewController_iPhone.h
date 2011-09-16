//
//  VsTheClockViewController_iPhone.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Question.h"

@interface VsTheClockViewController_iPhone : UIViewController
{
    NSManagedObjectContext* managedObjectContext;
    UIButton* correctButton;
    UIButton* wrongButton;
    UIButton* pauseButton;
    
    UILabel* timerLabel;
    UILabel* highScoreLabel;
    UILabel* upperTextLabel;
    UILabel* lowerTextLabel;
    UILabel* correctCountLabel;
    UILabel* wrongCountLabel;
    
    BOOL receivedMemoryWarning;
    NSUInteger currentLevel;
    NSMutableArray* allQuestions;
    NSArray* allQuestionsCopyForWrongAnswers;
    Question* currentQuestion;    
    NSUInteger currentScore;
    NSUInteger wrongCount;
    NSTimer* timer;
    NSUInteger countDown;
    NSUInteger levelUpgradeCount;

    UIImageView* xImage;
    UILabel* correctAnswerLabel;
    
    BOOL paused;
    
    UILabel* equalSignLabel;
    UILabel* nextQuestionUpperTextLabel;
    UILabel* nextQuestionLowerTextLabel;
    UILabel* nextQuestionEqualSignLabel;
    UILabel* levelLabel;    
    UIPageControl* levelPageControl;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;
@property(nonatomic,retain) IBOutlet UIButton* correctButton;
@property(nonatomic,retain) IBOutlet UIButton* wrongButton;
@property(nonatomic,retain) IBOutlet UIButton* pauseButton;

@property(nonatomic,retain) IBOutlet UILabel* timerLabel;
@property(nonatomic,retain) IBOutlet UILabel* highScoreLabel;
@property(nonatomic,retain) IBOutlet UILabel* upperTextLabel;
@property(nonatomic,retain) IBOutlet UILabel* lowerTextLabel;
@property(nonatomic,retain) IBOutlet UILabel* correctCountLabel;
@property(nonatomic,retain) IBOutlet UILabel* wrongCountLabel;

@property(nonatomic,retain) NSMutableArray* allQuestions;
@property(nonatomic,retain) NSArray* allQuestionsCopyForWrongAnswers;

@property (nonatomic, retain) IBOutlet UILabel *equalSignLabel;
@property (nonatomic, retain) IBOutlet UIPageControl *levelPageControl;

-(IBAction)correctButtonPressed:(id)sender;
-(IBAction)wrongButtonPressed:(id)sender;
-(IBAction)pauseButtonPressed:(id)sender;
-(void)startTheGame;

@end
