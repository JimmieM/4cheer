//
//  ThirdViewController.m
//  Chronicle Vision
//
//  Created by Jimmie Magnusson on 2016-08-05.
//  Copyright © 2016 Jimmie Magnusson. All rights reserved.
//

#import "ThirdViewController.h"
#import "MessageUI/MessageUI.h"

@interface ThirdViewController ()
{
    // counts foreach change of identity, max is 2.
    int identityCounter;
}

@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // forkey checks due load.
    [self customBreakLineForKeyCheck];
    [self nightModeForKeyCheck];
    [self gesturePressForKeyCheck];
    [self identityForKeyCheck];
    [self seperatorForKeyCheck];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gestureModeSwitchAction:(id)sender
{
    if (_gestureModeSwitch.on)
    {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"GestureSwipeActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _gestureModeSwitch.on = true;
        
        
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"GestureSwipeActivated"];
        _gestureModeSwitch.on = false;
       
    }
}

-(void)gesturePressForKeyCheck
{
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"GestureSwipeActivated"]){
        
        _gestureModeSwitch.on = true;
    }
    else {
        
    }
}


- (IBAction)nightModeSwitchAction:(id)sender
{
    if (_nightModeSwitch.on)
    {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"NightModeActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self nightModeActivate];
        
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NightModeActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _nightModeSwitch.on = false;
        
        [self nightModeDeactivate];
      
        
        
    }
}


// targets nsuserdefaults and checks if nightmode is either activated or deactivated
- (void)nightModeForKeyCheck
{
    // if activated
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"NightModeActivated"])
    {
        
        [self nightModeActivate];
    }
    // if deactivated
    else
    {
        [self nightModeDeactivate];
    }
}

// activating nightmode if forkey exist
- (void)nightModeActivate
{
    self.tableView.backgroundColor = [UIColor blackColor];
    // display
    // nightMode
    _nightModeCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
     _nightModeLabel.textColor = [UIColor whiteColor];
    _nightModeSwitch.on = true;
    
    // gesture swipe
    _gestureModeCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
    _gestureModeLabel.textColor = [UIColor whiteColor];
    
    // break line
    _breaklineCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
    _breaklineLabel.textColor = [UIColor whiteColor];
    
    // seperator
    _seperatorCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
    _seperatorLabel.textColor = [UIColor whiteColor];
    
    // own value
    _identityCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
    _identityLabel.textColor = [UIColor whiteColor];
    
    // share
    _shareCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
    _nightModeLabel.textColor = [UIColor whiteColor];
    _shareLabel.textColor = [UIColor whiteColor];
    
    // feedback
    _feedbackCell.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];
    _nightModeLabel.textColor = [UIColor whiteColor];
    _feedbackLabel.textColor = [UIColor whiteColor];
    
}

// deactivate method is only called when user switches of nightmode
// this method will be ran to only show instantly when switching off
- (void)nightModeDeactivate
{
    
    // table background
    self.tableView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:242.0/255.0 alpha:1.0];
    // display
    // nightMode
    _nightModeCell.backgroundColor = [UIColor whiteColor];
    _nightModeLabel.textColor = [UIColor blackColor];
    
    // gesture swipe
    _gestureModeCell.backgroundColor = [UIColor whiteColor];
    _gestureModeLabel.textColor = [UIColor blackColor];
    
    // line break
    _breaklineCell.backgroundColor = [UIColor whiteColor];
    _breaklineLabel.textColor = [UIColor blackColor];
    
    // identity
    _identityCell.backgroundColor = [UIColor whiteColor];
    _identityLabel.textColor = [UIColor blackColor];
    
    // seperator
    _seperatorCell.backgroundColor = [UIColor whiteColor];
    _seperatorLabel.textColor = [UIColor blackColor];
    
    // share
    _shareCell.backgroundColor = [UIColor whiteColor];
    _shareLabel.textColor = [UIColor blackColor];
    
    // feedback
    _feedbackCell.backgroundColor = [UIColor whiteColor];
    _feedbackLabel.textColor = [UIColor blackColor];
    
}

- (void)seperatorForKeyCheck
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"SeperatorActivated"])
    {
        _seperatorSwitch.on = true;
    }
    else
    {
        _seperatorSwitch.on = false;
    }
}

- (IBAction)seperatorSwitchAction:(id)sender
{
    if (_seperatorSwitch.on)
    {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"SeperatorActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else
    {
        // the object forkey will be removed.
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SeperatorActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _seperatorSwitch.on = false;
        
    }
}



- (IBAction)shareAction:(id)sender
{
    NSString *shareText = @"4cheer, the new storyteller app for iPhone!";
    NSArray *itemsToShare = @[shareText];
    UIActivityViewController *activityCV = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityCV.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard];
    [self presentViewController:activityCV animated:true completion:nil];
}

// mail
- (IBAction)feedbackAction:(id)sender
{
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    // email Subject
    NSString *emailTitle = @"Feedback for 4cheer";
    // email Content
    NSString * messageBody = [NSString stringWithFormat:@"Feedback:\n\n\n\n\r Sender ID: %@", uniqueIdentifier];
    // to address
    NSArray *toRecipents = [NSArray arrayWithObject:@"feedback@4cheer.net"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:false];
    [mc setToRecipients:toRecipents];

    [self presentViewController:mc animated:true completion:NULL];
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
  
            break;
        case MFMailComposeResultSaved:
            
            break;
        case MFMailComposeResultSent:
        {
            UIAlertController * alertMessageSuccess =   [UIAlertController
                        alertControllerWithTitle:@"Success!"
                        message:@"Thank you for the feedback."
                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     
                    [alertMessageSuccess dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alertMessageSuccess addAction:ok];
            
            [self presentViewController:alertMessageSuccess animated:YES completion:nil];
        }
             break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)customBreakLineForKeyCheck
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"BreaklineDefaultActivated"])
    {
        _breaklineSwitch.on = true;
    }
    else
    {
        _breaklineSwitch.on = false;
    }
}


- (IBAction)breaklineSwitchAction:(id)sender
{
    if (_breaklineSwitch.on)
    {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"BreaklineDefaultActivated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        // call for alert
        // when user confirms the new value
        // the object forkey will be removed.
        [self breakLineValue];
    }
}


-(void)breakLineValue
{
    // change current name of identity
    UIAlertController * alertChangeBreakLineValue =   [UIAlertController
                                                 alertControllerWithTitle:@"Change default line break"
                                                 message:@""
                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"Rename" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
                             
                             // remove for key.
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BreaklineDefaultActivated"];
                             
                             UITextField *alertTextField = alertChangeBreakLineValue.textFields.firstObject;
                             
                             // create NSString of name
                             NSString *savebreakvalue = alertTextField.text;
                             
                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                             // create the forkeys
                             [defaults setObject:savebreakvalue forKey:@"owntextvalue"];
                             [defaults synchronize];
        
                             // success alert
                             // call for chosen value
                             NSString *loadownvalue = [defaults objectForKey:@"owntextvalue"];
                             UIAlertController * alertLineBreakValueSuccess =   [UIAlertController
                                                                          alertControllerWithTitle:@"Success!"message:[NSString stringWithFormat:@"%@, is now your default value for line break.",loadownvalue]
                                                                          
                                                                          
                                                                          preferredStyle:UIAlertControllerStyleAlert];
                             UIAlertAction* ok = [UIAlertAction
                                                  actionWithTitle:@"Save"
                                                  style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action)
                                                  {
                                                      
                                                      [alertLineBreakValueSuccess dismissViewControllerAnimated:YES completion:nil];
                                                      
                                                  }];
                             [alertLineBreakValueSuccess addAction:ok];
                             
                             [self presentViewController:alertLineBreakValueSuccess animated:YES completion:nil];
                             
                             
                             
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 [alertChangeBreakLineValue dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alertChangeBreakLineValue addAction:ok];
    [alertChangeBreakLineValue addAction:cancel];
    
    [alertChangeBreakLineValue addTextFieldWithConfigurationHandler:^(UITextField *textField)
    {
        textField.placeholder = @"Value";
    }];
    
    
    [self presentViewController:alertChangeBreakLineValue animated:YES completion:nil];
}

- (IBAction)identityButton:(id)sender
{
    [self identityFunction];
}

-(void)identityForKeyCheck
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"IdentityExists"])
    {
        _identityLabel.text = @"Rename Identity";
    }
    
    // else keep current context
}

- (void)identityFunction
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    // change name of identity
    // user can only change identity twice
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"IdentityExists"])
    {
        
            // call for current name
            NSString *loadidentity = [defaults objectForKey:@"savedidentity"];
            // change current name of identity
            UIAlertController * alertChangeIdentity =   [UIAlertController
                                                         alertControllerWithTitle:@"Change your identity"
                                                         message:[NSString stringWithFormat:@"%@, what would you liked to be called?",loadidentity]
                                                         
                                                        
                                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Rename" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action)
                                 {
                                     UITextField *alertTextField = alertChangeIdentity.textFields.firstObject;
                                     
                                     // create NSString of name
                                     NSString *saveidentity = alertTextField.text;
                                     
                                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                     // create the forkeys
                                     [defaults setObject:saveidentity forKey:@"savedidentity"];
                                     [defaults synchronize];
                                     
                                     [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"IdentityExists"];
                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                     
                                     // account created alert
                                     // call for chosen name
                                     NSString *loadidentity = [defaults objectForKey:@"savedidentity"];
                                     UIAlertController * alertAccountCreated =   [UIAlertController
                                                                                  alertControllerWithTitle:@"Identity Changed"message:[NSString stringWithFormat:@"%@, You have successfully changed your identity!",loadidentity]
                                                                                  
                                                                                  
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                                     UIAlertAction* ok = [UIAlertAction
                                                          actionWithTitle:@"Continue"
                                                          style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                                          {
                                                              
                                                              [alertAccountCreated dismissViewControllerAnimated:YES completion:nil];
                                                              
                                                          }];
                                     [alertAccountCreated addAction:ok];
                                     
                                     [self presentViewController:alertAccountCreated animated:YES completion:nil];
                                     
                                     
                                     
                                     
                                 }];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action)
                                     {
                                         [alertChangeIdentity dismissViewControllerAnimated:YES completion:nil];
                                     }];
            
            [alertChangeIdentity addAction:ok];
            [alertChangeIdentity addAction:cancel];
            
            [alertChangeIdentity addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Name";
            }];
            
            
            [self presentViewController:alertChangeIdentity animated:YES completion:nil];
        }
    
        else
        {
            [self createIdentity];
        }
}


// this method will only be called in IBAction publishAction if user doesn't have an identity on the app yet
-(void)createIdentity
{
    UIAlertController * alertCreateAccount =   [UIAlertController
                                                alertControllerWithTitle:@"Create an identity"
                                                message:@"What would you like to be called?"
                                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Create" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
                             // declare identityCounter in ThirdViewController to 0
                             UITextField *alertTextField = alertCreateAccount.textFields.firstObject;
                             
                             // create NSString of name
                             NSString *saveidentity = alertTextField.text;
                             
                             // blacklist
                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                             if ([alertTextField.text isEqualToString:@"Fuck"] ||
                                 [alertTextField.text isEqualToString:@"Dick"] ||
                                 [alertTextField.text isEqualToString:@"Ass"] ||
                                 [alertTextField.text isEqualToString:@"Anus"] ||
                                 [alertTextField.text isEqualToString:@"Nigga"] ||
                                 [alertTextField.text isEqualToString:@"Nigger"] |
                                 [alertTextField.text isEqualToString:@"Retard"] |
                                 [alertTextField.text isEqualToString:@"Cock"] ||
                                 [alertTextField.text isEqualToString:@"Vag"] ||
                                 [alertTextField.text isEqualToString:@"Vagina"] |
                                 [alertTextField.text isEqualToString:@"Idiot"] ||
                                 [alertTextField.text isEqualToString:@"Fucking"] ||
                                 [alertTextField.text isEqualToString:@"Damn"] ||
                                 [alertTextField.text isEqualToString:@"Dumb"] ||
                                 [alertTextField.text isEqualToString:@"Fag"] ||
                                 [alertTextField.text isEqualToString:@"Gay"] ||
                                 [alertTextField.text isEqualToString:@"Whore"] ||
                                 [alertTextField.text isEqualToString:@"whore"] ||
                                 [alertTextField.text isEqualToString:@"dick"] ||
                                 [alertTextField.text isEqualToString:@"anus"] ||
                                 [alertTextField.text isEqualToString:@"nigga"] ||
                                 [alertTextField.text isEqualToString:@"fuck"] ||
                                 [alertTextField.text isEqualToString:@"nigger"] ||
                                 [alertTextField.text isEqualToString:@"retard"] ||
                                 [alertTextField.text isEqualToString:@"cock"] ||
                                 [alertTextField.text isEqualToString:@"vag"] ||
                                 [alertTextField.text isEqualToString:@"vagina"] ||
                                 [alertTextField.text isEqualToString:@"idiot"] ||
                                 [alertTextField.text isEqualToString:@"damn"] ||
                                 [alertTextField.text isEqualToString:@"dumb"] ||
                                 [alertTextField.text isEqualToString:@"bitch"] ||
                                 [alertTextField.text isEqualToString:@"Bitch"] ||
                                 [alertTextField.text isEqualToString:@"Pussy"] ||
                                 [alertTextField.text isEqualToString:@"pussy"] ||
                                 [alertTextField.text isEqualToString:@""] ||// empty
                                 [alertTextField.text isEqualToString:@"Negro"])
                             {
                                 
                                 UIAlertController * alertAccountFailed =   [UIAlertController
                                                                             alertControllerWithTitle:@"Rejected"
                                                                             message:@"Identity name rejected"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                                 UIAlertAction* ok = [UIAlertAction
                                                      actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                                      {
                                                          
                                                          [alertAccountFailed dismissViewControllerAnimated:YES completion:nil];
                                                          
                                                      }];
                                 [alertAccountFailed addAction:ok];
                                 [self presentViewController:alertAccountFailed animated:YES completion:nil];
                             }
                             
                             else
                             {
                                 // create the forkeys
                                 [defaults setObject:saveidentity forKey:@"savedidentity"];
                                 [defaults synchronize];
                                 
                                 [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"IdentityExists"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                 
                                 // account created alert
                                 // call for chosen name
                                 NSString *loadidentity = [defaults objectForKey:@"savedidentity"];
                                 UIAlertController * alertAccountCreated =   [UIAlertController
                                                                              alertControllerWithTitle:@"Identity Created"message:[NSString stringWithFormat:@"%@, You have successfully created an identity! You can now publish stories.",loadidentity]
                                                                              
                                                                              
                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                 UIAlertAction* ok = [UIAlertAction
                                                      actionWithTitle:@"Continue"
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                                      {
                                                          
                                                          [alertAccountCreated dismissViewControllerAnimated:YES completion:nil];
                                                          
                                                      }];
                                 [alertAccountCreated addAction:ok];
                                 
                                 [self presentViewController:alertAccountCreated animated:YES completion:nil];
                             }
                             
                             
                             
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 [alertCreateAccount dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alertCreateAccount addAction:ok];
    [alertCreateAccount addAction:cancel];
    
    [alertCreateAccount addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name";
    }];
    
    
    [self presentViewController:alertCreateAccount animated:YES completion:nil];
}

- (void)animatePressedDown:(UIButton *) sender duration:(double) t zoom:(double) zoomX
{
    [UIView animateWithDuration:t delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        sender.transform = CGAffineTransformMakeScale(zoomX,zoomX);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:t delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            sender.transform = CGAffineTransformMakeScale(1,1);
        } completion:nil];
    }];
}

@end


