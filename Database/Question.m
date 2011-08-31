//
//  Question.m
//  wordracedatabasebuilder
//
//  Created by Taha Selim Bebek on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Question.h"


@implementation Question
@synthesize englishText;
@synthesize translationText;
@synthesize correct;
@synthesize answeredCorrectly;
@synthesize correctAnswer;

-(id)init
{
    if ((self = [super init])) {
        self.englishText = @"";
        self.translationText = @"";
        self.correct = NO;
        self.answeredCorrectly = NO;
        self.correctAnswer = @"";
    }
    return self;
}
-(void)dealloc
{
    [correctAnswer release];
    [englishText release];
    [translationText release];
    [super dealloc];
}
@end
