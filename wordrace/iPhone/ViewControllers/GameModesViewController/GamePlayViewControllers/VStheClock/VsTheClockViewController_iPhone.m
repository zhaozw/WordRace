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


@implementation VsTheClockViewController_iPhone
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


-(void)gameOver
{
    NSUInteger highScore = 0;
    
    switch (currentLevel) {
        case 1:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockBeginner"];
            if (currentScore > highScore) 
            {
                [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreVsTheClockBeginner"];
                highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockBeginner"];
            }
            break;
        case 2:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockIntermediate"];
            if (currentScore > highScore) 
            {
                [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreVsTheClockIntermediate"];
                highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockIntermediate"];
            }
            break;
        case 3:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockAdvanced"];
            if (currentScore > highScore) 
            {
                [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreVsTheClockAdvanced"];
                highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockAdvanced"];
                
            }
            break;
    }
    
    
    GameOverViewController* gameOverViewController = [[GameOverViewController alloc]initWithNibName:@"GameOverViewController" bundle:nil];
    gameOverViewController.parentGamePlayViewController = (UIViewController*)self;
    gameOverViewController.currentGameMode = 1;
    gameOverViewController.currentLevel = currentLevel;
    gameOverViewController.score =currentScore;
    gameOverViewController.highScore = highScore;
    
    [self.navigationController pushViewController:gameOverViewController animated:NO];
    [gameOverViewController release];
    
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
    self.correctCountLabel.text = [NSString stringWithFormat:@"C: %i",currentScore];
    self.wrongCountLabel.text = [NSString stringWithFormat:@"F: %i",wrongCount];
}


-(void)checkCurrentLevel
{    
    currentLevel = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLevel"];
    
    if (currentLevel == 0) {
        currentLevel = 1;
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"currentLevel"];
    }
}

-(void)putHighScore
{
    NSInteger highScore = 0;
    switch (currentLevel) {
        case 1:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockBeginner"];
            break;
        case 2:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockIntermediate"];
            break;
        case 3:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreVsTheClockAdvanced"];
            break;
    }
    self.highScoreLabel.text = [NSString stringWithFormat:@"HS: %i",highScore];
    
}

-(void)createAllWords
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    switch (currentLevel) {
        case 1:
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"EasyWord" inManagedObjectContext:self.managedObjectContext]];
            break;
        case 2:
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"MediumWord" inManagedObjectContext:self.managedObjectContext]];
            break;
        case 3:
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"HardWord" inManagedObjectContext:self.managedObjectContext]];
            break;
    }
    [fetchRequest setPredicate:nil];
    
    NSError* errorCorrectWords = nil;
    allQuestionsCopyForWrongAnswers = [[managedObjectContext executeFetchRequest:fetchRequest error:&errorCorrectWords] retain];
    allQuestions = [[NSMutableArray alloc] initWithArray:allQuestionsCopyForWrongAnswers];
}

-(void)putNextQuestion
{
    NSInteger numberOfWords = [allQuestions count];
    NSInteger numberOfWordsForWrongAnswers = [allQuestionsCopyForWrongAnswers count];
    
    if (numberOfWords == 0) 
    {
        
        NSString* message = @"";
        
        switch (currentLevel) {
            case 1:
                message = @"Beginner seviyesini basariyla tamamladiniz. Bir ust seviyeye gecebilirsiniz.";
                break;
            case 2:
                message = @"Intermediate seviyesini basariyla tamamladiniz. Bir ust seviyeye gecebilirsiniz.";
                break;
            case 3:
                message = @"Advanced seviyesini basariyla tamamladiniz. Bir ust seviyeye gecebilirsiniz.";
                break;
        }
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Tebrikler" message:message delegate:self cancelButtonTitle:@"Yeniden Basla" otherButtonTitles:nil];
        [alert show];
        [self gameOver];
        return;
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
    }
    else
    {
        int rngWrong = 0;
        do {
            rngWrong = arc4random() % numberOfWordsForWrongAnswers;
        } while (rngWrong == rng);
        
        NSManagedObject* wordFalse = [allQuestionsCopyForWrongAnswers objectAtIndex:rngWrong];
        currentQuestion.translationText = [wordFalse valueForKey:@"translationString"];
        currentQuestion.correct = NO;
    }
    
    [allQuestions removeObjectAtIndex:rng];
    
    self.upperTextLabel.text = currentQuestion.englishText;
    self.lowerTextLabel.text = currentQuestion.translationText;
    self.correctButton.userInteractionEnabled = YES;
    self.wrongButton.userInteractionEnabled = YES;
}


-(void)startTimer
{
    //timer = [[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES] retain];
    timer = [[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES]retain];
    //[timer ];
}

-(void)startTheGame
{
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;
    
    currentScore = 0;
    wrongCount = 0;
    countDown = 101;
    
    [self updateScoreBoard];
    [self checkCurrentLevel];
    [self putHighScore];
    [self createAllWords];
    [self putNextQuestion];
    [self startTimer];
}

#pragma mark -
#pragma mark IBActions

-(IBAction)correctButtonPressed:(id)sender
{
    if (currentQuestion.correct) {
        currentScore = currentScore + 1;
    }
    else
    {
        wrongCount = wrongCount + 1;
    }
    
    [self updateScoreBoard];
    [self putNextQuestion];
}

-(IBAction)wrongButtonPressed:(id)sender
{
    if (currentQuestion.correct) 
    {
        wrongCount = wrongCount + 1;
    }
    else
    {
        currentScore = currentScore + 1;
    }
    [self updateScoreBoard];
    [self putNextQuestion];
}

-(IBAction)pauseButtonPressed:(id)sender
{
    PauseViewController* pauseViewController = [[PauseViewController alloc]initWithNibName:@"PauseViewController" bundle:nil];
    pauseViewController.parentGamePlayViewController = (UIViewController*)self;
    pauseViewController.currentGameMode = 2;
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
    
    [timerLabel release];
    [highScoreLabel release];
    [upperTextLabel release];
    [lowerTextLabel release];
    [correctCountLabel release];
    [wrongCountLabel release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
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

@end
