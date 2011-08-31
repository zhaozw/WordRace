//
//  DatabaseBuilderTVC.m
//  SurveyVoter
//
//  Created by Taha Bebek on 7/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatabaseBuilderTVC.h"
#import "WordRaceXMLParser.h"
#import "Constants.h"
@implementation DatabaseBuilderTVC

@synthesize managedObjectContext;
@synthesize frcEasyWords;
@synthesize frcMediumWords;
@synthesize frcHardWords;
@synthesize language;
@synthesize seeAll;
@synthesize allWords;
@synthesize searchText;

- (void)saveContext 
{
    
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
        } 
    }
}    


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (NSString *)applicationDocumentsDirectoryPath 
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)populateDatabase
{
    /*
    NSArray* languages = [NSArray arrayWithObjects:
                          @"afrikaan",
                          @"arabic",
                          @"armenian",
                          @"bulgarian",
                          @"chinese",
                          @"croatian",
                          @"czech",
                          @"danish",
                          @"dutch",
                          @"estonian",
                          @"filipino",
                          @"finnish",
                          @"french",
                          @"german",
                          @"greek",
                          @"hebrew",
                          @"hungarian",
                          @"indian",
                          @"indonesian",
                          @"italian",
                          @"japanese",
                          @"latvian",
                          @"lithuanian",
                          @"macedonian",
                          @"malay",
                          @"maltese",
                          @"norwegian",
                          @"polish",
                          @"portuguese",
                          @"romanian",
                          @"russian",
                          @"slovakian",
                          @"slovenian",
                          @"spanish",
                          @"swahili",
                          @"swedish",
                          @"tamil",
                          @"thai",
                          @"turkish",
                          @"urdu",
                          @"vietnamese",
                          nil];
    */
    NSArray* languages = [NSArray arrayWithObjects:
                          @"turkish",
                          nil];

    
    for (NSString* languageObject in languages) {
        
        WordRaceXMLParser* parser = [[WordRaceXMLParser alloc]init];
        parser.managedObjectContext = self.managedObjectContext;

        NSLog(@"parse easy %@",languageObject);
        parser.dataType = Easy;
        parser.language = languageObject;
        NSString* fileNameEasy = [NSString stringWithFormat:@"easywords_%@",languageObject];
        [parser parseXMLFile:[[NSBundle mainBundle] pathForResource:fileNameEasy ofType:@"xml"]];

        NSLog(@"parse medium %@",languageObject);
        parser.dataType = Medium;
        NSString* fileNameMedium = [NSString stringWithFormat:@"intermediatewords_%@",languageObject];
        [parser parseXMLFile:[[NSBundle mainBundle] pathForResource:fileNameMedium ofType:@"xml"]];

        NSLog(@"parse hard %@",languageObject);
        parser.dataType = Hard;
        NSString* fileNameHard = [NSString stringWithFormat:@"hardwords_%@",languageObject];
        [parser parseXMLFile:[[NSBundle mainBundle] pathForResource:fileNameHard ofType:@"xml"]];
        [parser release];
        
        [self saveContext];
        
        /*
        NSString* dataBaseFileName = [NSString stringWithFormat:@"WordRace.sqlite"];
        NSString* dataBaseFileNameForSpecificLanguage = [NSString stringWithFormat:@"WordRace_%@.sqlite",languageObject];
        
        NSString *storePath = [[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:dataBaseFileName];
        NSString *targetPath = [[self applicationDocumentsDirectoryPath] stringByAppendingPathComponent:dataBaseFileNameForSpecificLanguage];
        NSFileManager *fileManager = [NSFileManager defaultManager];

        [fileManager copyItemAtPath:storePath toPath:targetPath error:NULL];

        NSArray* easywords = self.frcEasyWords.fetchedObjects;
        NSArray* mediumwords = self.frcMediumWords.fetchedObjects;
        NSArray* hardwords = self.frcHardWords.fetchedObjects;

        for (NSManagedObject* object in easywords) {
            [self.managedObjectContext deleteObject:object];
        }
        for (NSManagedObject* object in mediumwords) {
            [self.managedObjectContext deleteObject:object];
        }
        for (NSManagedObject* object in hardwords) {
            [self.managedObjectContext deleteObject:object];
        }
        [self saveContext];
         */
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.searchText = @"";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = self.language;
    //[self populateDatabase];
    
    if (self.seeAll) 
    {
        self.allWords = [NSMutableArray array];
        [allWords addObjectsFromArray:self.frcEasyWords.fetchedObjects];
        [allWords addObjectsFromArray:self.frcMediumWords.fetchedObjects];
        [allWords addObjectsFromArray:self.frcHardWords.fetchedObjects];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    [managedObjectContext release];
    [language release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.seeAll) {
        return 1;
    } 
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* retString = @"";
    
    if (!self.seeAll) {
        switch (section) {
            case 0:
                retString = [NSString stringWithFormat:@"Easy %i",[self.frcEasyWords.fetchedObjects count]];
                break;
            case 1:
                retString = [NSString stringWithFormat:@"Medium %i",[self.frcMediumWords.fetchedObjects count]];
                break;
            case 2:
                retString = [NSString stringWithFormat:@"Hard %i",[self.frcHardWords.fetchedObjects count]];
                break;
        }
    }
    
    return retString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger retInt = 0;
    NSString* retString = @"";

    if (!self.seeAll) {
        switch (section) {
            case 0:
                retInt = [self.frcEasyWords.fetchedObjects count];
                retString = [NSString stringWithFormat:@"Easy %i",[self.frcEasyWords.fetchedObjects count]];
                break;
            case 1:
                retInt = [self.frcMediumWords.fetchedObjects count];
                retString = [NSString stringWithFormat:@"Medium %i",[self.frcMediumWords.fetchedObjects count]];
                break;
            case 2:
                retInt = [self.frcHardWords.fetchedObjects count];
                retString = [NSString stringWithFormat:@"Hard %i",[self.frcHardWords.fetchedObjects count]];
                break;
        }
    }
    else
    {
        retInt = [self.allWords count];
        retString = [NSString stringWithFormat:@"Total %i",[self.allWords count]];

    }
    
    NSLog(@"%@",retString);
    return retInt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSManagedObject* currentObject = [self.allWords objectAtIndex:indexPath.row];
    
    if (!self.seeAll) {
        switch (indexPath.section) {
            case 0:
                currentObject = [self.frcEasyWords.fetchedObjects objectAtIndex:indexPath.row];
                break;
            case 1:
                currentObject = [self.frcMediumWords.fetchedObjects objectAtIndex:indexPath.row];
                break;
            case 2:
                currentObject = [self.frcHardWords.fetchedObjects objectAtIndex:indexPath.row];
                break;
        }
    }
        
    cell.textLabel.text = [NSString stringWithFormat:@"%i - %@",[[currentObject valueForKey:@"indexNumber"] intValue],[currentObject valueForKey:@"englishString"]];
    cell.detailTextLabel.text = [currentObject valueForKey:@"translationString"];

    return cell;
}

#pragma mark -
#pragma mark fetched results controllers

- (NSFetchedResultsController *)frcEasyWords 
{	
    [frcEasyWords release];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"EasyWord" inManagedObjectContext:self.managedObjectContext]];
	
    if (self.seeAll) {
        [fetchRequest setPredicate:nil];
    } else {
        //NSPredicate* predicateLanguage = [NSPredicate predicateWithFormat:@"language == %@",self.language];
        if (![self.searchText isEqualToString:@""]) {
            NSPredicate* predicateSearch = [NSPredicate predicateWithFormat:@"englishString contains[cd] %@",self.searchText];
            //NSPredicate* predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicateLanguage,predicateSearch, nil]];
            [fetchRequest setPredicate:predicateSearch];
        }
        else
        {
            [fetchRequest setPredicate:nil];
        }
    }
    
	NSSortDescriptor*titleSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"indexNumber" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:titleSortDescriptor,nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[titleSortDescriptor release];
	
	frcEasyWords = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	[fetchRequest release];
	[frcEasyWords performFetch:nil];
    return frcEasyWords;
}

- (NSFetchedResultsController *)frcMediumWords
{	
    [frcMediumWords release];

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"MediumWord" inManagedObjectContext:self.managedObjectContext]];
    
    if (self.seeAll) {
        [fetchRequest setPredicate:nil];
    } else {
        //NSPredicate* predicateLanguage = [NSPredicate predicateWithFormat:@"language == %@",self.language];
        if (![self.searchText isEqualToString:@""]) {
            NSPredicate* predicateSearch = [NSPredicate predicateWithFormat:@"englishString contains[cd] %@",self.searchText];
            //NSPredicate* predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicateLanguage,predicateSearch, nil]];
            [fetchRequest setPredicate:predicateSearch];
        }
        else
        {
            [fetchRequest setPredicate:nil];
        }
    }
    
	NSSortDescriptor*titleSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"indexNumber" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:titleSortDescriptor,nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[titleSortDescriptor release];
	
	frcMediumWords = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	[fetchRequest release];
    [frcMediumWords performFetch:nil];

    return frcMediumWords;
}

- (NSFetchedResultsController *)frcHardWords
{	
    [frcHardWords release];

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"HardWord" inManagedObjectContext:self.managedObjectContext]];
    
    if (self.seeAll) {
        [fetchRequest setPredicate:nil];
    } else {
        //NSPredicate* predicateLanguage = [NSPredicate predicateWithFormat:@"language == %@",self.language];
        if (![self.searchText isEqualToString:@""]) {
            NSPredicate* predicateSearch = [NSPredicate predicateWithFormat:@"englishString contains[cd] %@",self.searchText];
            //NSPredicate* predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicateLanguage,predicateSearch, nil]];
            [fetchRequest setPredicate:predicateSearch];
        }
        else
        {
            [fetchRequest setPredicate:nil];
        }
    }
	
	NSSortDescriptor*titleSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"indexNumber" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:titleSortDescriptor,nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[titleSortDescriptor release];
	
	frcHardWords = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	[fetchRequest release];
    [frcHardWords performFetch:nil];

    return frcHardWords;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSManagedObject* currentObject = nil;
        
        if (self.seeAll) {
            currentObject = [self.allWords objectAtIndex:indexPath.row];
            [self.allWords removeObject:currentObject];
        }
        else
        {
            switch (indexPath.section) {
                case 0:
                    currentObject = [self.frcEasyWords.fetchedObjects objectAtIndex:indexPath.row];
                    break;
                case 1:
                    currentObject = [self.frcMediumWords.fetchedObjects objectAtIndex:indexPath.row];
                    break;
                case 2:
                    currentObject = [self.frcHardWords.fetchedObjects objectAtIndex:indexPath.row];
                    break;
            }
        }
        [self.managedObjectContext deleteObject:currentObject];
        [self saveContext];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
 


#pragma mark-
#pragma search

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.seeAll) {
        self.searchText = searchBar.text;
        NSPredicate* predicateSearch = [NSPredicate predicateWithFormat:@"englishString contains[cd] %@",self.searchText];
        self.allWords = [NSMutableArray arrayWithArray:[allWords filteredArrayUsingPredicate:predicateSearch]];
        [self.tableView reloadData];
        [self.searchDisplayController.searchResultsTableView reloadData];
        
    } else {
        self.searchText = searchBar.text;
        [self.tableView reloadData];
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
    [searchBar resignFirstResponder];
}



@end
