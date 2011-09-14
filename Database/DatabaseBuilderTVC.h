//
//  DatabaseBuilderTVC.h
//  SurveyVoter
//
//  Created by Taha Bebek on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DatabaseBuilderTVC : UITableViewController <UISearchBarDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    
    NSFetchedResultsController* frcEasyWords;
    
    NSString* language;
    BOOL seeAll;
    NSMutableArray* allWords;
    NSString* searchText;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) NSFetchedResultsController* frcEasyWords;
@property (nonatomic, retain) NSString* language;
@property (nonatomic, retain) NSString* searchText;
@end
