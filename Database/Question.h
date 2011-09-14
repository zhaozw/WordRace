//
//  Question.h
//  wordracedatabasebuilder
//
//  Created by Taha Selim Bebek on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Question : NSObject 
{
    NSString* englishText;
    NSString* translationText;
    NSString* correctAnswer;
    NSInteger level;
    BOOL correct;
    BOOL answeredCorrectly;
}
@property(nonatomic,retain) NSString* englishText;
@property(nonatomic,retain) NSString* translationText;
@property(nonatomic) BOOL correct;
@property(nonatomic) BOOL answeredCorrectly;
@property(nonatomic,retain) NSString* correctAnswer;
@property(nonatomic,assign) NSInteger level;
@end
