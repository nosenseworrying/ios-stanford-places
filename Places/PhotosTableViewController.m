//
//  PhotosTableViewController.m
//  Places
//
//  Created by Matt Augustine on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "PhotoViewController.h"

@interface PhotosTableViewController()
    @property (retain, nonatomic) NSArray *photosArray;
@end

@implementation PhotosTableViewController

@synthesize photosLocation, locationID;
@synthesize photosArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setPhotosLocation:(NSString *)newPhotosLocation
{
    if(photosLocation != newPhotosLocation){
        [photosLocation release];
        photosLocation = [newPhotosLocation copy];
    }
    
    self.title  = photosLocation;
}

- (void) setLocationID:(NSString *)newLocationID
{
    if(locationID != newLocationID){
        [locationID release];
        locationID = [newLocationID copy];
    }
    
    // Fetch 'dem photos
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.photosArray = [FlickrFetcher photosAtPlace:locationID];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //NSLog(@"%@", self.photosArray);
}

- (void)dealloc
{
    [photosArray release];
    [photosLocation release];
    [locationID release];
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
    return self.photosArray.count;
}

- (NSDictionary *) photoDictionaryAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.photosArray objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary *photoDictionary = [self photoDictionaryAtIndexPath:indexPath];
    NSString *title = [photoDictionary objectForKey:@"title"];
    NSDictionary *descriptionDictionary = [photoDictionary objectForKey:@"description"];
    NSString *description = [descriptionDictionary objectForKey:@"_content"];
    
    if([title isEqual:@""]){
        title = @"No Title";
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = description;
    
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
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    //NSDictionary *photoDictionary = [self photoDictionaryAtIndexPath:indexPath];
    photoVC.photoDictionary = [self photoDictionaryAtIndexPath:indexPath];
    
    [self.navigationController pushViewController:photoVC animated:YES];
    [photoVC release];
}

@end
