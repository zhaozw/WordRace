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
    UILabel* consequtiveCorrectAnswersCountLabel;
    UILabel* highScoreLabel;
    UILabel* upperTextLabel;
    UILabel* lowerTextLabel;
    UILabel* equalSignLabel;
    UILabel* nextQuestionUpperTextLabel;
    UILabel* nextQuestionLowerTextLabel;
    UILabel* nextQuestionEqualSignLabel;
    
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
    NSUInteger levelUpgradeCount;
        
    UIImageView* xImage;
    UILabel* correctAnswerLabel;
    UILabel* levelLabel;
    
    UIPageControl* levelPageControl;
}

@property(nonatomic,retain) NSManagedObjectContext* managedObjectContext;
@property(nonatomic,retain) IBOutlet UIButton* correctButton;
@property(nonatomic,retain) IBOutlet UIButton* wrongButton;
@property(nonatomic,retain) IBOutlet UIButton* pauseButton;

@property(nonatomic,retain) IBOutlet UILabel* scoreBoardLabel;
@property(nonatomic,retain) IBOutlet UILabel* consequtiveCorrectAnswersCountLabel;

@property(nonatomic,retain) IBOutlet UILabel* highScoreLabel;
@property(nonatomic,retain) IBOutlet UILabel* upperTextLabel;
@property(nonatomic,retain) IBOutlet UILabel* lowerTextLabel;
@property(nonatomic,retain) IBOutlet UIImageView* firstLifeImageView;
@property(nonatomic,retain) IBOutlet UIImageView* secondLifeImageView;
@property(nonatomic,retain) IBOutlet UIImageView* thirdLifeImageView;
@property(nonatomic,retain) NSMutableArray* allQuestions;
@property(nonatomic,retain) NSArray* allQuestionsCopyForWrongAnswers;

@property(nonatomic,retain) IBOutlet UILabel* equalSignLabel;
@property(nonatomic,retain) IBOutlet UIPageControl* levelPageControl;

-(IBAction)correctButtonPressed:(id)sender;
-(IBAction)wrongButtonPressed:(id)sender;
-(IBAction)pauseButtonPressed:(id)sender;
-(void)startTheGame;

@end
