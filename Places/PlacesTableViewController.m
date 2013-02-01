//
//  PlacesTableViewController.m
//  Places
//
//  Created by Matt Augustine on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "PhotosTableViewController.h"
#import "FlickrFetcher.h"

@interface PlacesTableViewController()
    @property (retain, nonatomic) NSArray *placesArray;
@end

@implementation PlacesTableViewController

@synthesize placesArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray*)placesArray{
    if(!placesArray){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSArray* unsortedPlacesArray = [[FlickrFetcher topPlaces] retain];
        
        // Sort the array by location name
        NSSortDescriptor *locationDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"_content" ascending:YES] autorelease];
        placesArray = [[unsortedPlacesArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:locationDescriptor]] retain];
        [unsortedPlacesArray autorelease];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
    
    return placesArray;
}

- (void)dealloc
{
    [placesArray release];
    [super dealloc];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    /*for(NSDictionary *placeDictionary in self.placesArray){
        NSString *location = [placeDictionary objectForKey:@"_content"];
        NSString *place_id = [placeDictionary objectForKey:@"place_id"];
        NSLog(@"loc: %@", location);
        NSLog(@"place_id: %@", place_id);
    }*/
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.placesArray.count;
}

- (NSDictionary *) placeDictionaryAtIndexPath:(NSIndexPath*) indexPath
{
    return [self.placesArray objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary *placeDictionary = [self placeDictionaryAtIndexPath:indexPath];
    NSArray *fullLocationArray = [[placeDictionary objectForKey:@"_content"] componentsSeparatedByString:@","];
    int locationSize = fullLocationArray.count;
    NSString *maintext;
    NSString *subtext;
    
    if(locationSize > 2){
        NSString *city = [fullLocationArray objectAtIndex:0];
        NSString *state = [fullLocationArray objectAtIndex:1];
        NSString *country = [fullLocationArray objectAtIndex:2];
        subtext = [state stringByAppendingString:@","];
        
        maintext = city;
        subtext = [subtext stringByAppendingString:country];
        
    } else if(locationSize > 1){
        maintext = [fullLocationArray objectAtIndex:0];
        subtext = [fullLocationArray objectAtIndex:1];
        
    } else if(locationSize > 0){
        maintext =  [fullLocationArray objectAtIndex:0];
        subtext = @"Unknown";
    } else {
        maintext = @"Unknown";
        subtext = @"Unknown";
    }
    
    cell.textLabel.text = maintext;
    cell.detailTextLabel.text = subtext;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;    
        
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    
    PhotosTableViewController *photosTVC = [[PhotosTableViewController alloc] init];
    NSDictionary *placeDictionary = [self placeDictionaryAtIndexPath:indexPath];
    NSArray *fullLocationArray = [[placeDictionary objectForKey:@"_content"] componentsSeparatedByString:@","];
    photosTVC.photosLocation = [fullLocationArray objectAtIndex:0];
    photosTVC.locationID = [placeDictionary objectForKey:@"place_id"];
    
    [self.navigationController pushViewController:photosTVC animated:YES];
}

@end
