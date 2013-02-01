//
//  PhotoViewController.m
//  Places
//
//  Created by Matt Augustine on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrFetcher.h"

@interface PhotoViewController()
    @property (retain) UIImageView *imageView;
    @property (retain) UIScrollView *scrollView;
@end

@implementation PhotoViewController

@synthesize photoDictionary, photoTitle;
@synthesize imageView, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define MAX_NUM_RECENTS 10
- (void) updateRecents:(NSDictionary *)newPhotoDictionary
{
    NSString *id = [newPhotoDictionary objectForKey:@"id"];
    
    if([id isEqual:nil] || [id isEqual:@""]){
        NSLog(@"UNABLE TO GET PHOTO ID -- IGNORING...");
    } else {
        NSUserDefaults* state = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *photoList = [[state dictionaryForKey:@"photoList"] mutableCopy];
        NSMutableArray *keyList = [[state arrayForKey:@"keyList"] mutableCopy];
        
        if(keyList == nil){
            // This is a brand new instance
            photoList = [[NSMutableDictionary alloc] init];
            keyList = [[NSMutableArray alloc] init];
        }
        
        int numOfPhotos = [keyList count];
        
        if(numOfPhotos == MAX_NUM_RECENTS){
            // First check if this photo is already in the list
            // If it is, we can just shuffle
            NSDictionary *existingPhoto = [photoList objectForKey:id];
            
            if(existingPhoto != nil){
                [photoList removeObjectForKey:id];
                [keyList removeObject:id];
            } else {
                // If it didn't already exist
                // we have to remove the oldest first
                NSString *oldestKey = [keyList objectAtIndex:MAX_NUM_RECENTS - 1];
                [photoList removeObjectForKey:oldestKey];
                [keyList removeObjectAtIndex:MAX_NUM_RECENTS - 1];   
            }
            
            // Add the new photo to the beginning
            [keyList insertObject:id atIndex:0];
            [photoList setObject:newPhotoDictionary forKey:id];
            
        } else {
            // we can freely add more
            // Shuffle if it's already in the list
            NSDictionary *existingPhoto = [photoList objectForKey:id];
            
            if(existingPhoto != nil){
                [photoList removeObjectForKey:id];
                [keyList removeObject:id];
            }
            
            // Add the new photo to the beginning
            [keyList insertObject:id atIndex:0];
            [photoList setObject:newPhotoDictionary forKey:id];
        }
        
        [state setObject:photoList forKey:@"photoList"];
        [state setObject:keyList forKey:@"keyList"];
        [state synchronize];
        
        [photoList autorelease];
        [keyList autorelease];
    }
}

- (void) setPhotoDictionary:(NSDictionary *)newPhotoDictionary
{
    if(photoDictionary != newPhotoDictionary){
        [photoDictionary release];
        photoDictionary = [newPhotoDictionary retain];
    }
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)dealloc
{
    [photoTitle release];
    [photoDictionary release];
    [imageView release];
    [scrollView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    // Set the title
    self.title = [self.photoDictionary objectForKey:@"title"];
    
    // Modify the recents
    [self updateRecents:self.photoDictionary];
    
    // Get dat photo!
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSData *imageData = [FlickrFetcher imageDataForPhotoWithFlickrInfo:photoDictionary format:FlickrFetcherPhotoFormatLarge];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //self.image = [UIImage imageWithData:imageData];
    UIImage *photo = [UIImage imageWithData:imageData];
    self.imageView = [[UIImageView alloc] initWithImage:photo];
    
    // Create a UIScrollView for the UIImage View
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	scrollView = [[UIScrollView alloc] initWithFrame:applicationFrame];
    //CGRect initialFrame = scrollView.frame;
    
	scrollView.contentSize = photo.size;
	[scrollView addSubview:self.imageView];
    
	scrollView.bounces = NO;
    
	scrollView.minimumZoomScale = 0.3;
	scrollView.maximumZoomScale = 3.0;
	scrollView.delegate = self;
    
    CGFloat photoWidth = photo.size.width;
    CGFloat photoHeight = photo.size.height;
    
    //NSLog(@"photowidth: %f, photoheight: %f", photoWidth, photoHeight);
    
    if(photoWidth > photoHeight){
        //NSLog(@"scrollview bounds width: %f", scrollView.bounds.size.width);
        //NSLog(@"scrollview bounds height: %f", scrollView.bounds.size.height);
        
        CGFloat scaleFactor = (scrollView.bounds.size.height / photoHeight);
        //NSLog(@"scale factor: %f", scaleFactor);
        CGFloat newWidth = photoWidth * scaleFactor;
        //NSLog(@"new width: %f", newWidth);
        
        CGRect zoomRect = CGRectMake(0, 0, newWidth, photoHeight);
        //NSLog(@"content offset y: %f", scrollView.contentOffset.y);
        //NSLog(@"content inset top: %f", scrollView.contentInset.top);
        //NSLog(@"content inset bottom: %f", scrollView.contentInset.bottom);
        
        [scrollView zoomToRect:zoomRect animated:YES];
    } else {
        CGRect zoomRect = CGRectMake(0,0, photoWidth, scrollView.bounds.size.height);
        [scrollView zoomToRect:zoomRect animated:YES];
    }
    
    self.view = scrollView;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
