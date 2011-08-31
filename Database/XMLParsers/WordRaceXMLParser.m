//
//  WordRaceXMLParser.m
//  SurveyVoter
//
//  Created by Taha Bebek on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WordRaceXMLParser.h"

NSString* const kLitWorkSheet           = @"Worksheet";
NSString* const kLitRow                 = @"Row";
NSString* const kLitCell                = @"Cell";
NSString* const kLitData				= @"Data";


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
    NSLog(@"%s",__FUNCTION__);
    self.index = 0;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
	if ([kLitWorkSheet isEqualToString:elementName]) 
    {
    }
    else if ([kLitRow isEqualToString:elementName]) 
    {
    }
    else if ([kLitCell isEqualToString:elementName]) 
    {
    }
    else if ([kLitData isEqualToString:elementName]) 
    {
        currentElementValueString = [NSMutableString string];

        if (parsingEnglishString) {
            parsingEnglishString = NO;
        } else {
            switch (self.dataType) {
                case Easy:
                    currentWord = [NSEntityDescription insertNewObjectForEntityForName:@"EasyWord" inManagedObjectContext:managedObjectContext];
                    break;
                case Medium:
                    currentWord = [NSEntityDescription insertNewObjectForEntityForName:@"MediumWord" inManagedObjectContext:managedObjectContext];
                    break;
                case Hard:
                    currentWord = [NSEntityDescription insertNewObjectForEntityForName:@"HardWord" inManagedObjectContext:managedObjectContext];
                    break;
            }
            parsingEnglishString = YES;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{	
	if ([kLitWorkSheet isEqualToString:elementName]) 
    {
    }
    else if ([kLitRow isEqualToString:elementName]) 
    {
        //NSLog(@"%@",currentEasyWord);
    }
    else if ([kLitCell isEqualToString:elementName]) 
    {
    }
    else if ([kLitData isEqualToString:elementName]) 
    {
        EasyWord* easyWord = nil;
        MediumWord* mediumWord = nil;
        HardWord* hardWord = nil;
        
        
        if (parsingEnglishString) {
            
            switch (self.dataType) {
                case Easy:
                    easyWord = (EasyWord*)currentWord;
                    easyWord.englishString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    break;
                case Medium:
                    mediumWord = (MediumWord*)currentWord;
                    mediumWord.englishString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    break;
                case Hard:
                    hardWord = (HardWord*)currentWord;
                    hardWord.englishString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    break;
            }            
        } else {
            //NSLog(@"Translation %@",currentElementValueString);
            switch (self.dataType) {
                case Easy:
                    easyWord = (EasyWord*)currentWord;
                    easyWord.translationString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    easyWord.language = self.language;
                    easyWord.indexNumber = [NSNumber numberWithInteger:index];
                    index = index + 1;
                    break;
                case Medium:
                    mediumWord = (MediumWord*)currentWord;
                    mediumWord.translationString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    mediumWord.language = self.language;
                    mediumWord.indexNumber = [NSNumber numberWithInteger:index];
                    index = index + 1;
                    break;
                case Hard:
                    hardWord = (HardWord*)currentWord;
                    hardWord.translationString = [[currentElementValueString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
                    hardWord.language = self.language;
                    hardWord.indexNumber = [NSNumber numberWithInteger:index];
                    index = index + 1;
                    break;
            }
            
            
            //[self saveContext];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__FUNCTION__);
    //[self saveContext];
}


@end
