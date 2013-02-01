//
//  PhotosTableViewController.h
//  Places
//
//  Created by Matt Augustine on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotosTableViewController : UITableViewController {
    NSString *photosLocation;
    NSString *locationID;
    NSArray *photosArray;
}

@property (retain, nonatomic) NSString *photosLocation;
@property (retain, nonatomic) NSString *locationID;

@end
