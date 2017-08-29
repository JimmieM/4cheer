//
//  SecondViewController.h
//  Chronicle Vision
//
//  Created by Jimmie Magnusson on 2016-07-23.
//  Copyright © 2016 Jimmie Magnusson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "ThirdViewController.h"

#import <MessageUI/MFMailComposeViewController.h>

@interface SecondViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *savedStories;
- (IBAction)storeStories:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *storeStoriesbtn;


// nav bar left / right

@property (weak, nonatomic) IBOutlet UIButton *settingsAction;

// publish action

- (IBAction)publishAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *publishActionbtn;

// publish chronicle
@property (weak, nonatomic) IBOutlet UIButton *publishChroniclebtn;

// options utilities

// right side
@property (weak, nonatomic) IBOutlet UIButton *sendChronicleSMSbtn;
- (IBAction)sendChronicleSMS:(id)sender;

- (IBAction)clearData:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearDatabtn;

// left side
@property (weak, nonatomic) IBOutlet UIButton *addBreakLinebtn;
- (IBAction)addBreakLine:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *customEditbtn;
- (IBAction)customEdit:(id)sender;

// bottom navbar

@property (weak, nonatomic) IBOutlet UINavigationBar *bottomNavigation;


// first launch properties

// share
@property (weak, nonatomic) IBOutlet UIImageView *firstLaunchShareImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLaunchShareLabel;

// edit
@property (weak, nonatomic) IBOutlet UIImageView *firstLaunchEditImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLaunchEditLabel;

// wipe
@property (weak, nonatomic) IBOutlet UIImageView *firstLaunchWipeImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLaunchWipeLabel;

// line break
@property (weak, nonatomic) IBOutlet UIImageView *firstLaunchLinebreakImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLaunchLinebreakLabel;

// continue btn
@property (weak, nonatomic) IBOutlet UIButton *firstLaunchContinue;
- (IBAction)firstLaunchContinueAction:(id)sender;











@end

