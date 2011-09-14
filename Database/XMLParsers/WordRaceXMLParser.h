//
//  WordRaceXMLParser.h
//  SurveyVoter
//
//  Created by Taha Bebek on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyWord.h"
#import <CoreData/CoreData.h>

typedef enum {
	Easy,
    Medium,
    Hard,
}DataType;

@interface WordRaceXMLParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser* xmlParser;
    NSMutableString* currentElementValueString;
    BOOL parsingEnglishString;
    NSManagedObjectContext* managedObjectContext;
    EasyWord* currentWord;
    DataType dataType;
    
    NSString* language;
    NSInteger index;
}

- (void)parseXMLFile:(NSString*)filePath;

@property (nonatomic,retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic)  DataType dataType;
@property (nonatomic,retain) NSString* language;
@property (nonatomic) NSInteger index;
@end
