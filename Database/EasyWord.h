//
//  EasyWord.h
//  wordrace
//
//  Created by Taha Selim Bebek on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EasyWord : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * dictionaryDefinition;
@property (nonatomic, retain) NSString * englishString;
@property (nonatomic, retain) NSString * falseTranslation;
@property (nonatomic, retain) NSNumber * indexNumber;
@property (nonatomic, retain) NSNumber * isAnsweredCorrect;
@property (nonatomic, retain) NSNumber * isRightQuestion;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSNumber * spareInt1;
@property (nonatomic, retain) NSNumber * spareInt2;
@property (nonatomic, retain) NSNumber * spareInt3;
@property (nonatomic, retain) NSString * spareString1;
@property (nonatomic, retain) NSString * spareString2;
@property (nonatomic, retain) NSString * spareString3;
@property (nonatomic, retain) NSString * translationString;
@property (nonatomic, retain) NSString * wordType;
@property (nonatomic, retain) NSNumber * level;

@end
