//
//  PhotoViewController.h
//  Places
//
//  Created by Matt Augustine on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoViewController : UIViewController <UIScrollViewDelegate> {
    NSDictionary *photoDictionary;
    NSString *photoTitle;
    UIImageView *imageView;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) NSDictionary *photoDictionary;
@property (nonatomic, retain) NSString *photoTitle;

@end
