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
@synthesize highScoreLabel;
@synthesize upperTextLabel;
@synthesize lowerTextLabel;
@synthesize firstLifeImageView;
@synthesize secondLifeImageView;
@synthesize thirdLifeImageView;

#pragma mark -
#pragma mark game
#pragma mark -

-(void)gameOver
{
    NSUInteger highScore = 0;

    switch (currentLevel) {
        case 1:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesBeginner"];
            if (currentScore > highScore) 
            {
                [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreThreeLivesBeginner"];
                highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesBeginner"];
            }
            break;
        case 2:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesIntermediate"];
            if (currentScore > highScore) 
            {
                [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreThreeLivesIntermediate"];
                highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesIntermediate"];
            }
            break;
        case 3:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesAdvanced"];
            if (currentScore > highScore) 
            {
                [[NSUserDefaults standardUserDefaults] setInteger:currentScore forKey:@"highScoreThreeLivesAdvanced"];
                highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesAdvanced"];

            }
            break;
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


-(void)updateScoreBoard
{
    self.scoreBoardLabel.text = [NSString stringWithFormat:@"%i",currentScore];
}


-(void)updateLiveImages
{
    switch (currentNumberOfLives) {
        case 1:
            self.firstLifeImageView.alpha = 1.0;
            self.secondLifeImageView.alpha = 0.0;
            self.thirdLifeImageView.alpha = 0.0;
            break;
        case 2:
            self.firstLifeImageView.alpha = 1.0;
            self.secondLifeImageView.alpha = 1.0;
            self.thirdLifeImageView.alpha = 0.0;
            break;
        case 3:
            self.firstLifeImageView.alpha = 1.0;
            self.secondLifeImageView.alpha = 1.0;
            self.thirdLifeImageView.alpha = 1.0;
            break;
    }
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
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesBeginner"];
            break;
        case 2:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesIntermediate"];
            break;
        case 3:
            highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScoreThreeLivesAdvanced"];
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


-(void)startTheGame
{
    self.correctButton.userInteractionEnabled = NO;
    self.wrongButton.userInteractionEnabled = NO;
        
    currentScore = 0;
    consequtiveCorrectAnswersCount = 1;
    currentNumberOfLives = 3;
    
    [self updateLiveImages];
    [self updateScoreBoard];
    [self checkCurrentLevel];
    [self putHighScore];
    [self createAllWords];
    [self putNextQuestion];
}


#pragma mark IBActions

-(IBAction)correctButtonPressed:(id)sender
{
    if (currentQuestion.correct) {
        currentScore = currentScore + consequtiveCorrectAnswersCount;

        if (consequtiveCorrectAnswersCount != 10) 
        {
            consequtiveCorrectAnswersCount = consequtiveCorrectAnswersCount +1;
        }
        [self updateScoreBoard];
    }
    else
    {
        if (currentNumberOfLives != 1) {
            currentNumberOfLives = currentNumberOfLives - 1;
            [self updateLiveImages];
        }
        else
        {
            [self gameOver];
            return;
        }
    }
    
    [self putNextQuestion];
}

-(IBAction)wrongButtonPressed:(id)sender
{
    if (currentQuestion.correct) 
    {
        if (currentNumberOfLives != 1) {
            currentNumberOfLives = currentNumberOfLives - 1;
            [self updateLiveImages];
        }
        else
        {
            [self gameOver];
            return;
        }
    }
    else
    {
        currentScore = currentScore + consequtiveCorrectAnswersCount;
        if (consequtiveCorrectAnswersCount != 10) 
        {
            consequtiveCorrectAnswersCount = consequtiveCorrectAnswersCount +1;
        }
        [self updateScoreBoard];
    }
    [self putNextQuestion];
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
    receivedMemoryWarning = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
