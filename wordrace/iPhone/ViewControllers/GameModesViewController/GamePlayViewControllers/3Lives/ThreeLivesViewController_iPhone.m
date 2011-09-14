//
//  ThreeLivesViewController_iPhone.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThreeLivesViewController_iPhone.h"
#import "PauseViewController.h"
#import "GameOverViewController.h"


@implementation ThreeLivesViewController_iPhone
@synthesize managedObjectContext;
@synthesize correctButton;
@synthesize wrongButton;
@synthesize pauseButton;

@synthesize scoreBoardLabel;
@synthesize consequtiveCorrectAnswersCountLabel;
@synthesize highScoreLabel;
@synthesize upperTextLabel;
@synthesize lowerTextLabel;
@synthesize firstLifeImageView;
@synthesize secondLifeImageView;
@synthesize thirdLifeImageView;
@synthesize allQuestions;
@synthesize allQuestionsCopyForWrongAnswers;

#pragma mark -
#pragma mark game
#pragma mark -

-(void)gameOver
{
    NSUInteger highScore = 0;
    highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLives"];
    if (currentScore > highScore) 
    {
        [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreThreeLives"];
        highScore = currentScore;
    }
        
    GameOverViewController* gameOverViewController = [[GameOverViewController alloc]initWithNibName:@"GameOverViewController" bundle:nil];
    gameOverViewController.parentGamePlayViewController = (UIViewController*)self;
    gameOverViewController.currentGameMode = 0;
    gameOverViewController.currentLevel = currentLevel;
    gameOverViewController.score =currentScore;
    gameOverViewController.highScore = highScore;

    [self.navigationController pushViewController:gameOverViewController animated:NO];
    [gameOverViewController release];

}

-(void)updateLevelLabel
{
    self.highScoreLabel.text = [NSString stringWithFormat:@"Seviye %i",currentLevel +1];
}

-(void)updateScoreBoard
{
    self.scoreBoardLabel.text = [NSString stringWithFormat:@"%i",currentScore];
}

-(void)updateConsequtiveCorrectAnswersCountLabel
{
    self.consequtiveCorrectAnswersCountLabel.text = [NSString stringWithFormat:@"x %i",consequtiveCorrectAnswersCount];
}


-(void)updateLiveImages
{
    switch (currentNumberOfLives) {
        case 0:
            self.firstLifeImageView.highlighted = YES;
            self.secondLifeImageView.highlighted = YES;
            self.thirdLifeImageView.highlighted = YES;
            break;
        case 1:
            self.firstLifeImageView.highlighted = NO;
            self.secondLifeImageView.highlighted = YES;
            self.thirdLifeImageView.highlighted = YES;
            break;
        case 2:
            self.firstLifeImageView.highlighted = NO;
            self.secondLifeImageView.highlighted = NO;
            self.thirdLifeImageView.highlighted = YES;
            break;
        case 3:
            self.firstLifeImageView.highlighted = NO;
            self.secondLifeImageView.highlighted = NO;
            self.thirdLifeImageView.highlighted = NO;
            break;
    }
}

-(void)giveExtraLife
{
    //NSLog(@"%s",__FUNCTION__);
    extraLifeGiven = YES;
    currentNumberOfLives = currentNumberOfLives +1;
    [self updateLiveImages];    
}

-(void)checkCurrentLevel
{    
    currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLevel"];
}

-(void)createAllWordsForCurrentLevel
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"EasyWord" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate* levelPredicate = [NSPredicate predicateWithFormat:@"level == %@",[NSNumber numberWithInt:currentLevel]];
    [fetchRequest setPredicate:levelPredicate];

    NSError* errorCorrectWords = nil;
    self.allQuestionsCopyForWrongAnswers = [managedObjectContext executeFetchRequest:fetchRequest error:&errorCorrectWords];
    self.allQuestions = [[[NSMutableArray alloc] initWithArray:allQuestionsCopyForWrongAnswers] autorelease];
}

-(void)putNextQuestion
{
    NSInteger numberOfWords = [allQuestions count];
    NSInteger numberOfWordsForWrongAnswers = [allQuestionsCopyForWrongAnswers count];

    if (numberOfWords == 0) {
        [self createAllWordsForCurrentLevel];
        numberOfWords = [allQuestions count];
        numberOfWordsForWrongAnswers = [allQuestionsCopyForWrongAnswers count];
    }
    int rng = arc4random() % numberOfWords;
    
    NSManagedObject* word = [allQuestions objectAtIndex:rng];
    
    [currentQuestion release];
    currentQuestion = [[Question alloc] init];
    currentQuestion.englishText = [word valueForKey:@"englishString"];
    
    int rngCorrect = arc4random() % 2;
    if (rngCorrect == 0) {
        currentQuestion.correct = YES;
        currentQuestion.translationText = [word valueForKey:@"translationString"];
        currentQuestion.correctAnswer = [word valueForKey:@"translationString"];
    }
    else
    {
        int rngWrong = 0;
        do {
            rngWrong = arc4random() % numberOfWordsForWrongAnswers;
        } while (rngWrong == rng);
        
        NSManagedObject* wordFalse = [allQuestionsCopyForWrongAnswers objectAtIndex:rngWrong];
        currentQuestion.translationText = [wordFalse valueForKey:@"translationString"];
        currentQuestion.correctAnswer = [word valueForKey:@"translationString"];
        currentQuestion.correct = NO;
    }
    
    [allQuestions removeObjectAtIndex:rng];
    
    self.upperTextLabel.text = currentQuestion.englishText;
    self.lowerTextLabel.text = currentQuestion.translationText;
    self.correctButton.userInteractionEnabled = YES;
    self.wrongButton.userInteractionEnabled = YES;
}

-(void)upgradeLevel
{
    levelUpgradeCount = 0;
    if (currentLevel != 39) {
        currentLevel = currentLevel + 1;
        [self createAllWordsForCurrentLevel];
        [self updateLevelLabel];
    }
}
     
-(void)downgradeLevel
{
    levelUpgradeCount = 0;

    if (currentLevel != 0) {
        currentLevel = currentLevel - 1;
        [self createAllWordsForCurrentLevel];
        [self updateLevelLabel];
    }
}

-(void)startTheGame
{
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;
        
    currentScore = 0;
    consequtiveCorrectAnswersCount = 1;
    currentNumberOfLives = 3;
    levelUpgradeCount = 0;
    
    [self updateLiveImages];
    [self updateScoreBoard];
    [self updateConsequtiveCorrectAnswersCountLabel];
    [self checkCurrentLevel];
    [self updateLevelLabel];
    [self createAllWordsForCurrentLevel];
    [self putNextQuestion];
}

-(void)showCorrectAnswerWithAnimation
{
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;

    currentNumberOfLives = currentNumberOfLives - 1;
    consequtiveCorrectAnswersCount = 1;
    [self updateLiveImages];
    extraLifeGiven = NO;
    [self downgradeLevel];
    
    [xImage release];
    xImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Glyph3LivesOn.png"]];
    
    switch (currentNumberOfLives) {
        case 0:
            xImage.center = self.firstLifeImageView.center;
            break;
        case 1:
            xImage.center = self.secondLifeImageView.center;
            break;
        case 2:
            xImage.center = self.thirdLifeImageView.center;
            break;
    }
    [self.view addSubview:xImage];

    [UIView beginAnimations:@"MoveX" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedMovingX)];
    xImage.center = self.lowerTextLabel.center;
    [UIView commitAnimations];
}

-(void)finishedMovingX
{
    [correctAnswerLabel release];
    correctAnswerLabel = [[UILabel alloc] initWithFrame:CGRectMake(320, self.lowerTextLabel.frame.origin.y, self.lowerTextLabel.frame.size.width, self.lowerTextLabel.frame.size.height)];
    correctAnswerLabel.alpha = 0.0;
    correctAnswerLabel.text = currentQuestion.correctAnswer;
    correctAnswerLabel.backgroundColor = [UIColor clearColor];
    correctAnswerLabel.textColor = [UIColor whiteColor];
    correctAnswerLabel.font = self.lowerTextLabel.font;
    correctAnswerLabel.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:correctAnswerLabel];
    
    [UIView beginAnimations:@"ShowCorrectAnswer" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(userAnsweredWrongly)];
    correctAnswerLabel.alpha = 1.0;
    correctAnswerLabel.frame = self.lowerTextLabel.frame;
    self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, -320, 0);
    xImage.frame = CGRectOffset(xImage.frame, -320, 0);
    [UIView commitAnimations]; 
}

-(void)userAnsweredWrongly
{
    [NSThread sleepForTimeInterval:1];
    [correctAnswerLabel removeFromSuperview];
    [xImage removeFromSuperview];
    self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, 320, 0);

    if (currentNumberOfLives == 0) {
        
        [self gameOver];
        return;
    }

    [self updateConsequtiveCorrectAnswersCountLabel];
    [self putNextQuestion];
    
    self.correctButton.userInteractionEnabled = YES;
    self.wrongButton.userInteractionEnabled = YES;

}

-(void)userAnsweredCorrecty
{
    currentScore = currentScore + consequtiveCorrectAnswersCount;
    
    if (consequtiveCorrectAnswersCount != 5) 
    {
        consequtiveCorrectAnswersCount = consequtiveCorrectAnswersCount +1;
    }
    if (consequtiveCorrectAnswersCount == 5) 
    {
        if (!extraLifeGiven) {
            if (currentNumberOfLives != 3) 
            {
                [self giveExtraLife];
            }
        }
    }
    [self updateScoreBoard];
    
    if (levelUpgradeCount != 4) 
    {
        levelUpgradeCount = levelUpgradeCount +1;
    }
    else
    {
        [self upgradeLevel];
    }
    [self updateConsequtiveCorrectAnswersCountLabel];
    [self putNextQuestion];
}



#pragma mark IBActions

-(IBAction)correctButtonPressed:(id)sender
{
    if (currentQuestion.correct) 
    {
        [self userAnsweredCorrecty];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(showCorrectAnswerWithAnimation) withObject:nil waitUntilDone:YES];
    }
}

-(IBAction)wrongButtonPressed:(id)sender
{
    if (currentQuestion.correct) 
    {
        [self performSelectorOnMainThread:@selector(showCorrectAnswerWithAnimation) withObject:nil waitUntilDone:YES];
    }
    else
    {
        [self userAnsweredCorrecty];
    }
}

-(IBAction)pauseButtonPressed:(id)sender
{
    PauseViewController* pauseViewController = [[PauseViewController alloc]initWithNibName:@"PauseViewController" bundle:nil];
    pauseViewController.parentGamePlayViewController = (UIViewController*)self;
    pauseViewController.currentGameMode = 0;
    pauseViewController.currentLevel = currentLevel;
    
    [self.navigationController pushViewController:pauseViewController animated:NO];
    [pauseViewController release];
}


#pragma mark -
#pragma mark Lifecycle

- (void)dealloc
{
    [managedObjectContext release];
    [correctButton release];
    [wrongButton release];
    [pauseButton release];
    
    [scoreBoardLabel release];
    [consequtiveCorrectAnswersCountLabel release];
    [highScoreLabel release];
    [upperTextLabel release];
    [lowerTextLabel release];
    [firstLifeImageView release];
    [secondLifeImageView release];
    [thirdLifeImageView release];
    [allQuestionsCopyForWrongAnswers release];
    [allQuestions release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scoreBoardLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:34]];
    [consequtiveCorrectAnswersCountLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:16]];

    //self.scoreBoardLabel.font = [UIFont fontWithName:@"Digital-7" size:34];
    //self.scoreBoardLabel.font = [UIFont systemFontOfSize:34];

    if (!receivedMemoryWarning) 
    {
        [self startTheGame];
    }
    else
    {
        receivedMemoryWarning = NO;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    receivedMemoryWarning = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
