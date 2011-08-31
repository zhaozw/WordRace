//
//  ThreeLivesViewController_iPhone.h
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Question.h"

@interface ThreeLivesViewController_iPhone : UIViewController <UIAlertViewDelegate>
{
    NSManagedObjectContext* managedObjectContext;
    UIButton* correctButton;
    UIButton* wrongButton;
    UIButton* pauseButton;
    
    UILabel* scoreBoardLabel;
    UILabel* highScoreLabel;
    UILabel* upperTextLabel;
    UILabel* lowerTextLabel;
    UIImageView* firstLifeImageView;
    UIImageView* secondLifeImageView;
    UIImageView* thirdLifeImageView;

    BOOL receivedMemoryWarning;
    NSUInteger currentLevel;
    NSMutableArray* allQuestions;
    NSArray* allQuestionsCopyForWrongAnswers;
    Question* currentQuestion;
    
    NSUInteger currentScore;
    NSUInteger consequtiveCorrectAnswersCount;
    NSUInteger currentNumberOfLives;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;
@property(nonatomic,retain) IBOutlet UIButton* correctButton;
@property(nonatomic,retain) IBOutlet UIButton* wrongButton;
@property(nonatomic,retain) IBOutlet UIButton* pauseButton;

@property(nonatomic,retain) IBOutlet UILabel* scoreBoardLabel;
@property(nonatomic,retain) IBOutlet UILabel* highScoreLabel;
@property(nonatomic,retain) IBOutlet UILabel* upperTextLabel;
@property(nonatomic,retain) IBOutlet UILabel* lowerTextLabel;
@property(nonatomic,retain) IBOutlet UIImageView* firstLifeImageView;
@property(nonatomic,retain) IBOutlet UIImageView* secondLifeImageView;
@property(nonatomic,retain) IBOutlet UIImageView* thirdLifeImageView;

-(IBAction)correctButtonPressed:(id)sender;
-(IBAction)wrongButtonPressed:(id)sender;
-(IBAction)pauseButtonPressed:(id)sender;
-(void)startTheGame;

@end
