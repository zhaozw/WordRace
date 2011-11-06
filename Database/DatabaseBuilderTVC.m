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
@synthesize language;
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
    
    for (NSString* languageObject in languages) 
    {
        WordRaceXMLParser* parser = [[WordRaceXMLParser alloc]init];
        parser.managedObjectContext = self.managedObjectContext;
        parser.dataType = Easy;
        parser.language = languageObject;
        [parser parseXMLFile:[[NSBundle mainBundle] pathForResource:@"Turkish" ofType:@"xml"]];
        [self saveContext];
    }
}


void QuietLog (NSString *format, ...)
{
    va_list argList;
    va_start (argList, format);
    NSString *message = [[[NSString alloc] initWithFormat: format
                                                arguments: argList] autorelease];
    printf ("%s", [message UTF8String]);
    va_end  (argList);
    
} // QuietLog


- (void)checkMP3
{    
    for (EasyWord* object in self.frcEasyWords.fetchedObjects) 
    {
        QuietLog(@"\n%@",object.englishString);
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
    [self populateDatabase];
    //[self checkMP3];
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
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* retString = @"";
    retString = [NSString stringWithFormat:@"Easy %i",[self.frcEasyWords.fetchedObjects count]];
    
    return retString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger retInt = 0;
    retInt = [self.frcEasyWords.fetchedObjects count];
    
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
    NSManagedObject* currentObject = [self.frcEasyWords.fetchedObjects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i - %@",[[currentObject valueForKey:@"level"] intValue],[currentObject valueForKey:@"englishString"]];
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
	NSSortDescriptor*titleSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"englishString" ascending:YES];
    NSSortDescriptor*levelSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"level" ascending:YES];

	NSArray *sortDescriptors = [NSArray arrayWithObjects:levelSortDescriptor,titleSortDescriptor,nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[titleSortDescriptor release];
	
	frcEasyWords = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	[fetchRequest release];
	[frcEasyWords performFetch:nil];
    return frcEasyWords;
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
        currentObject = [self.frcEasyWords.fetchedObjects objectAtIndex:indexPath.row];

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
    self.searchText = searchBar.text;
    [self.tableView reloadData];
    [self.searchDisplayController.searchResultsTableView reloadData];
    [searchBar resignFirstResponder];
}



@end
