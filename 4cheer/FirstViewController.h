//
//  FirstViewController.h
//  Chronicle Vision
//
//  Created by Jimmie Magnusson on 2016-07-23.
//  Copyright © 2016 Jimmie Magnusson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface FirstViewController : UIViewController
@property (assign) SecondViewController *savedStories;

// first launch
@property (weak, nonatomic) IBOutlet UILabel *detailSaveLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailSaveLongPressureLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailFirstSaveLabel;

// nav
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

// random story actions
@property (weak, nonatomic) IBOutlet UIButton *randomStory;
- (IBAction)randomStorySwipeGesture:(id)sender;

// story text
@property (weak, nonatomic) IBOutlet UITextView *storyLabel;

// save
- (IBAction)saveStory:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveStorybtn;
// hold for save
- (IBAction)saveStoryLongPress:(id)sender;

@end

