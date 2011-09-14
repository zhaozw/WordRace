//
//  WordRaceXMLParser.m
//  SurveyVoter
//
//  Created by Taha Bebek on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WordRaceXMLParser.h"
#include "math.h"

NSString* const kLitWord                = @"word";
NSString* const kLitLevel               = @"level";
NSString* const kLitEnglish             = @"english";
NSString* const kLitTurkish             = @"turkish";

@implementation WordRaceXMLParser
@synthesize managedObjectContext;
@synthesize dataType;
@synthesize language;
@synthesize index;


- (void)saveContext 
{
    
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
        } 
    }
}    


- (id)init
{
    self = [super init];
    if (self) {
		currentElementValueString = [[NSMutableString alloc] init];
        self.index = 0;
    }
    
    return self;
}



- (void)parseXMLFile:(NSString*)filePath
{
    NSURL* fileURL = [NSURL fileURLWithPath:filePath];
    
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    xmlParser.delegate = self;
    
    [xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[currentElementValueString appendString:string];
}


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.index = 0;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElementValueString = [NSMutableString string];
    
	if ([kLitWord isEqualToString:elementName]) 
    {
        currentWord = [NSEntityDescription insertNewObjectForEntityForName:@"EasyWord" inManagedObjectContext:managedObjectContext];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	
	if ([kLitWord isEqualToString:elementName]) 
    {
        index = index +1;
        NSLog(@"%@",currentWord);
    }
    else if ([kLitLevel isEqualToString:elementName]) 
    {
        NSInteger currentLevel = (NSInteger)ceil(index / 70);
        currentWord.level = [NSNumber numberWithInt:currentLevel];
    }
    else if ([kLitEnglish isEqualToString:elementName]) 
    {
        currentWord.englishString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    }
    else if ([kLitTurkish isEqualToString:elementName]) 
    {
        currentWord.translationString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
            //[self saveContext];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__FUNCTION__);
    [self saveContext];
}


@end
