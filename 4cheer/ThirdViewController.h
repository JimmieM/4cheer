//
//  ThirdViewController.h
//  Chronicle Vision
//
//  Created by Jimmie Magnusson on 2016-08-05.
//  Copyright © 2016 Jimmie Magnusson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <iAd/iAd.h>

// email not in use
#import <MessageUI/MFMailComposeViewController.h>

@interface ThirdViewController : UITableViewController<MFMailComposeViewControllerDelegate , ADBannerViewDelegate>



// settings
// display

// nightmode
// cell
@property (weak, nonatomic) IBOutlet UITableViewCell *nightModeCell;
// label
@property (weak, nonatomic) IBOutlet UILabel *nightModeLabel;

// switch
@property (weak, nonatomic) IBOutlet UISwitch *nightModeSwitch;
- (IBAction)nightModeSwitchAction:(id)sender;

// swipe gesture
// cell
@property (weak, nonatomic) IBOutlet UITableViewCell *gestureModeCell;

//label
@property (weak, nonatomic) IBOutlet UILabel *gestureModeLabel;


//switch
@property (weak, nonatomic) IBOutlet UISwitch *gestureModeSwitch;
- (IBAction)gestureModeSwitchAction:(id)sender;


// story seperator

// cell
@property (weak, nonatomic) IBOutlet UITableViewCell *seperatorCell;

// label
@property (weak, nonatomic) IBOutlet UILabel *seperatorLabel;


// switch
@property (weak, nonatomic) IBOutlet UISwitch *seperatorSwitch;
- (IBAction)seperatorSwitchAction:(id)sender;



// profile

// default break line
// cell
@property (weak, nonatomic) IBOutlet UIView *breaklineCell;

// label
@property (weak, nonatomic) IBOutlet UILabel *breaklineLabel;

// switch
@property (weak, nonatomic) IBOutlet UISwitch *breaklineSwitch;
- (IBAction)breaklineSwitchAction:(id)sender;

// break line own value
//cell
@property (weak, nonatomic) IBOutlet UITableViewCell *ownValueCell;

// textfield
@property (weak, nonatomic) IBOutlet UITextField *ownValueTextField;

// button
@property (weak, nonatomic) IBOutlet UIButton *ownValueButton;

// create an identity

// cell
@property (weak, nonatomic) IBOutlet UITableViewCell *identityCell;

// label
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;

// button
- (IBAction)identityButton:(id)sender;






// share

// tell others
//cell
@property (weak, nonatomic) IBOutlet UIView *shareCell;

// label
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;

//button
- (IBAction)shareAction:(id)sender;


// feedback
// cell
@property (weak, nonatomic) IBOutlet UITableViewCell *feedbackCell;
// label
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
// button
- (IBAction)feedbackAction:(id)sender;

@end
