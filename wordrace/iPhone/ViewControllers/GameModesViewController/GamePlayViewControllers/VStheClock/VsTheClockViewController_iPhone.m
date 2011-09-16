//
//  VsTheClockViewController_iPhone.m
//  wordrace
//
//  Created by Taha Selim Bebek on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VsTheClockViewController_iPhone.h"
#import "PauseViewController.h"
#import "GameOverViewController.h"
#import "Constants.h"

@interface VsTheClockViewController_iPhone (P)
-(void)gameOver;
-(void)createAllWordsForCurrentLevel;
-(void)putNextQuestion;
-(void)updateLevelLabelForStart;
-(void)finishedShowingLevelLabel;
-(void)finishedMovingLevelLabel;
-(void)finishedMovingQuestion;
-(void)updateScoreBoard;
-(void)updateConsequtiveCorrectAnswersCountLabel;
-(void)updateLiveImages;
-(void)giveExtraLife;
-(void)checkCurrentLevel;
-(void)updateCurrentLevel;
-(void)startTheGame;
-(void)startNextQuestionAnimation;
-(void)upgradeLevel;
-(void)downgradeLevel;
-(void)showCorrectAnswerWithAnimation;
-(void)finishedMovingX;
-(void)finishedMovingXForCorrectQuestion;
-(void)userAnsweredWrongly;
-(void)userAnsweredCorrecty;
-(void)startTimer;
@end


@implementation VsTheClockViewController_iPhone

#pragma mark -
#pragma mark game start and finish
#pragma mark -

-(void)startTheGame
{
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;
    
    currentScore = 0;
    wrongCount = 0;
    countDown = 100;
    levelUpgradeCount = 0;
    self.highScoreLabel.text = @"";
    self.levelPageControl.currentPage = levelUpgradeCount;

    [self updateScoreBoard];
    [self checkCurrentLevel];
    [self createAllWordsForCurrentLevel];
    [self updateLevelLabelForStart];
}


-(void)gameOver
{
    NSUInteger highScore  = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClock"];
    GameOverViewController* gameOverViewController = [[GameOverViewController alloc]initWithNibName:@"GameOverViewController" bundle:nil];

    if (currentScore > highScore) 
    {
        gameOverViewController.didBrakeHighScore = YES;
        [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreVsTheClock"];
        highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClock"];
    }

    
    gameOverViewController.parentGamePlayViewController = (UIViewController*)self;
    gameOverViewController.currentGameMode = 1;
    gameOverViewController.gameMode = GAMEMODE_VSTHECLOCK_TITLE;
    gameOverViewController.currentLevel = currentLevel;
    gameOverViewController.score =currentScore;
    gameOverViewController.highScore = highScore;
    
    [self.navigationController pushViewController:gameOverViewController animated:NO];
    [gameOverViewController release];
    
}

#pragma mark -
#pragma mark question creation
#pragma mark -

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
        NSManagedObject* wordFalse = nil;
        do {
            rngWrong = arc4random() % numberOfWordsForWrongAnswers;
            wordFalse = [allQuestionsCopyForWrongAnswers objectAtIndex:rngWrong];
            currentQuestion.translationText = [wordFalse valueForKey:@"translationString"];
            currentQuestion.correctAnswer = [word valueForKey:@"translationString"];
            currentQuestion.correct = NO;
        } while ([[wordFalse valueForKey:@"translationString"] isEqualToString:[word valueForKey:@"translationString"]]);
    }
    
    [allQuestions removeObjectAtIndex:rng];
    
    self.upperTextLabel.text = currentQuestion.englishText;
    self.lowerTextLabel.text = currentQuestion.translationText;
}

#pragma mark -
#pragma mark updates without animation
#pragma mark -

-(void)startTimer
{
    timer = [[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES]retain];
}

-(void)updateTimer:(NSTimer*)aTimer
{
    countDown = countDown - 1;
    self.timerLabel.text = [NSString stringWithFormat:@"%i",countDown];
    
    if (countDown == 0) 
    {
        [timer invalidate];
        [timer release];
        timer = nil;
        [self gameOver];
    }
}

-(void)updateScoreBoard
{
    self.correctCountLabel.text = [NSString stringWithFormat:@"%i",currentScore];
    self.wrongCountLabel.text = [NSString stringWithFormat:@"%i",wrongCount];
}


-(void)checkCurrentLevel
{    
    currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLevel"];
}

-(void)updateCurrentLevel
{
    [[NSUserDefaults standardUserDefaults] setInteger:currentLevel forKey:@"currentLevel"];
}

#pragma mark -
#pragma mark level upgrade and downgrade
#pragma mark -

-(void)upgradeLevel
{
    levelUpgradeCount = 0;
    self.levelPageControl.currentPage = levelUpgradeCount;
    if (currentLevel != 39) {
        self.highScoreLabel.text = @"";
        currentLevel = currentLevel + 1;
        
        NSString* lockString = [NSString stringWithFormat:@"Level%i",currentLevel];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:lockString];
        
        [self updateCurrentLevel];
        [self createAllWordsForCurrentLevel];
        [self updateLevelLabelForStart];
    }
}

-(void)downgradeLevel
{
    levelUpgradeCount = 0;
    self.levelPageControl.currentPage = levelUpgradeCount;
    
    if (currentLevel != 0) {
        self.highScoreLabel.text = @"";
        currentLevel = currentLevel - 1;
        [self updateCurrentLevel];
        [self createAllWordsForCurrentLevel];
        [self updateLevelLabelForStart];
    }
    else
    {
        [self startNextQuestionAnimation];
    }
}

-(void)updateLevelLabelForStart
{
    [timer invalidate];
    [timer release];
    timer = nil;
    
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;
    self.pauseButton.userInteractionEnabled = NO;
    
    [levelLabel release];
    levelLabel = [[UILabel alloc] initWithFrame:self.upperTextLabel.frame];
    levelLabel.center = self.equalSignLabel.center;
    levelLabel.text = [NSString stringWithFormat:@"%@ %i",SELECTLEVEL_LEVEL_TITLE,currentLevel +1];
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.font = self.upperTextLabel.font;
    levelLabel.textAlignment = UITextAlignmentCenter;
    levelLabel.backgroundColor = [UIColor clearColor];
    levelLabel.alpha = 0.0;
    [self.view addSubview:levelLabel];
    
    self.upperTextLabel.frame = CGRectOffset(self.upperTextLabel.frame, 320, 0);
    self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, 320, 0);
    self.equalSignLabel.frame = CGRectOffset(self.equalSignLabel.frame, 320, 0);
    self.upperTextLabel.alpha = 0.0;
    self.lowerTextLabel.alpha = 0.0;
    self.equalSignLabel.alpha = 0.0;
    
    [UIView beginAnimations:@"ShowLevelLabel" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedShowingLevelLabel)];
    levelLabel.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)finishedShowingLevelLabel
{
    [NSThread sleepForTimeInterval:1];
    [UIView beginAnimations:@"MoveLevelLabel" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedMovingLevelLabel)];
    levelLabel.center = self.highScoreLabel.center;
    levelLabel.font = highScoreLabel.font;
    self.highScoreLabel.alpha = 0.0;
    [UIView commitAnimations];
}

-(void)finishedMovingLevelLabel
{
    self.highScoreLabel = levelLabel;
    [self putNextQuestion];
    
    [UIView beginAnimations:@"MoveLevelLabel" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedMovingQuestion)];
    self.upperTextLabel.frame = CGRectOffset(self.upperTextLabel.frame, -320, 0);
    self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, -320, 0);
    self.equalSignLabel.frame = CGRectOffset(self.equalSignLabel.frame, -320, 0);
    self.upperTextLabel.alpha = 1.0;
    self.lowerTextLabel.alpha = 1.0;
    self.equalSignLabel.alpha = 1.0;
    [UIView commitAnimations];
    [self startTimer];
}

-(void)finishedMovingQuestion
{
    self.correctButton.userInteractionEnabled = YES;
    self.wrongButton.userInteractionEnabled = YES;
    self.pauseButton.userInteractionEnabled = YES;
}


#pragma mark -
#pragma mark next question animations
#pragma mark -


-(void)startNextQuestionAnimation
{
    [nextQuestionUpperTextLabel release];
    nextQuestionUpperTextLabel = [[UILabel alloc] initWithFrame:self.upperTextLabel.frame];
    nextQuestionUpperTextLabel.text = self.upperTextLabel.text;
    nextQuestionUpperTextLabel.textColor = [UIColor whiteColor];
    nextQuestionUpperTextLabel.font = self.upperTextLabel.font;
    nextQuestionUpperTextLabel.textAlignment = UITextAlignmentCenter;
    nextQuestionUpperTextLabel.backgroundColor = [UIColor clearColor];
    nextQuestionUpperTextLabel.numberOfLines = 0;
    [self.view addSubview:nextQuestionUpperTextLabel];
    
    [nextQuestionLowerTextLabel release];
    nextQuestionLowerTextLabel = [[UILabel alloc] initWithFrame:self.lowerTextLabel.frame];
    nextQuestionLowerTextLabel.text = self.lowerTextLabel.text;
    nextQuestionLowerTextLabel.textColor = [UIColor whiteColor];
    nextQuestionLowerTextLabel.font = self.lowerTextLabel.font;
    nextQuestionLowerTextLabel.textAlignment = UITextAlignmentCenter;
    nextQuestionLowerTextLabel.backgroundColor = [UIColor clearColor];
    nextQuestionLowerTextLabel.numberOfLines = 0;
    [self.view addSubview:nextQuestionLowerTextLabel];
    
    [nextQuestionEqualSignLabel release];
    nextQuestionEqualSignLabel = [[UILabel alloc] initWithFrame:self.equalSignLabel.frame];
    nextQuestionEqualSignLabel.text = self.equalSignLabel.text;
    nextQuestionEqualSignLabel.textColor = [UIColor whiteColor];
    nextQuestionEqualSignLabel.font = self.equalSignLabel.font;
    nextQuestionEqualSignLabel.textAlignment = UITextAlignmentCenter;
    nextQuestionEqualSignLabel.backgroundColor = [UIColor clearColor];
    nextQuestionEqualSignLabel.numberOfLines = 0;
    [self.view addSubview:nextQuestionEqualSignLabel];
    
    self.upperTextLabel.frame = CGRectOffset(self.upperTextLabel.frame, 320, 0);
    self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, 320, 0);
    self.equalSignLabel.frame = CGRectOffset(self.equalSignLabel.frame, 320, 0);
    self.upperTextLabel.alpha = 0.0;
    self.lowerTextLabel.alpha = 0.0;
    self.equalSignLabel.alpha = 0.0;
    [self putNextQuestion];
    
    [UIView beginAnimations:@"ShowLevelLabel" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedMovingQuestion)];
    self.upperTextLabel.frame = CGRectOffset(self.upperTextLabel.frame, -320, 0);
    self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, -320, 0);
    self.equalSignLabel.frame = CGRectOffset(self.equalSignLabel.frame, -320, 0);
    self.upperTextLabel.alpha = 1.0;
    self.lowerTextLabel.alpha = 1.0;
    self.equalSignLabel.alpha = 1.0;
    
    nextQuestionUpperTextLabel.frame = CGRectOffset(nextQuestionUpperTextLabel.frame, -320, 0);
    nextQuestionLowerTextLabel.frame = CGRectOffset(nextQuestionLowerTextLabel.frame, -320, 0);
    nextQuestionEqualSignLabel.frame = CGRectOffset(nextQuestionEqualSignLabel.frame, -320, 0);
    nextQuestionUpperTextLabel.alpha = 0.0;
    nextQuestionLowerTextLabel.alpha = 0.0;
    nextQuestionEqualSignLabel.alpha = 0.0;
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark answered correctly
#pragma mark -

-(void)userAnsweredCorrecty
{
    currentScore = currentScore + 1;
    [self updateScoreBoard];
    
    if (levelUpgradeCount != 4) 
    {
        levelUpgradeCount = levelUpgradeCount +1;
        self.levelPageControl.currentPage = levelUpgradeCount;
        [self startNextQuestionAnimation];
    }
    else
    {
        [self upgradeLevel];
    }
}


#pragma mark -
#pragma mark answered wrongly
#pragma mark -


-(void)showCorrectAnswerWithAnimation
{
    [timer invalidate];
    [timer release];
    timer = nil;
    
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;
    self.pauseButton.userInteractionEnabled = NO;

    wrongCount = wrongCount + 1;
    [self updateScoreBoard];

    [xImage release];
    xImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Glyph3LivesOn.png"]];
    xImage.center = self.lowerTextLabel.center;
    xImage.alpha = 0.0;
    [self.view addSubview:xImage];
    
    [UIView beginAnimations:@"MoveX" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    if (currentQuestion.correct) 
    {
        [UIView setAnimationDidStopSelector:@selector(finishedMovingXForCorrectQuestion)];
    }
    else
    {
        [UIView setAnimationDidStopSelector:@selector(finishedMovingX)];
    }
    xImage.alpha = 1.0;
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

-(void)finishedMovingXForCorrectQuestion
{
    //NSLog(@"%s",__FUNCTION__);
    [UIView beginAnimations:@"ShowCorrectAnswer" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(userAnsweredWrongly)];
    xImage.alpha = 0.0;
    [UIView commitAnimations]; 
}

-(void)userAnsweredWrongly
{
    [NSThread sleepForTimeInterval:1];
    [correctAnswerLabel removeFromSuperview];
    [xImage removeFromSuperview];
    if (!currentQuestion.correct)self.lowerTextLabel.frame = CGRectOffset(self.lowerTextLabel.frame, 320, 0);
    self.correctButton.userInteractionEnabled = YES;
    self.wrongButton.userInteractionEnabled = YES;
    self.pauseButton.userInteractionEnabled = YES;
    [self downgradeLevel];
}

#pragma mark -
#pragma mark IBActions
#pragma mark -


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
    [timer invalidate];
    [timer release];
    timer = nil;
    paused = YES;
    
    PauseViewController* pauseViewController = [[PauseViewController alloc]initWithNibName:@"PauseViewController" bundle:nil];
    pauseViewController.parentGamePlayViewController = (UIViewController*)self;
    pauseViewController.currentGameMode = 1;
    pauseViewController.currentLevel = currentLevel;
    
    [self.navigationController pushViewController:pauseViewController animated:NO];
    [pauseViewController release];
}


#pragma mark -
#pragma mark Lifecycle


- (void)dealloc
{
    [allQuestions release];
    [allQuestionsCopyForWrongAnswers release];
    [managedObjectContext release];
    [correctButton release];
    [wrongButton release];
    [pauseButton release];
    
    [timerLabel release];
    [highScoreLabel release];
    [upperTextLabel release];
    [lowerTextLabel release];
    [correctCountLabel release];
    [wrongCountLabel release];
    [equalSignLabel release];
    [levelPageControl release];

    [timer invalidate];
    [timer release];
    timer = nil;
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

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (paused) {
        paused = NO;
        [self startTimer];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.timerLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:34]];

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
    // Release any retained subviews of the main view.
    receivedMemoryWarning = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Synthesizers
#pragma mark -

@synthesize managedObjectContext;
@synthesize correctButton;
@synthesize wrongButton;
@synthesize pauseButton;
@synthesize timerLabel;
@synthesize highScoreLabel;
@synthesize upperTextLabel;
@synthesize lowerTextLabel;
@synthesize correctCountLabel;
@synthesize wrongCountLabel;
@synthesize allQuestions;
@synthesize allQuestionsCopyForWrongAnswers;
@synthesize equalSignLabel;
@synthesize levelPageControl;

@end
