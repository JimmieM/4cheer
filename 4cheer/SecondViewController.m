//
//  SecondViewController.m
//  Chronicle Vision
//
//  Created by Jimmie Magnusson on 2016-07-23.
//  Copyright © 2016 Jimmie Magnusson. All rights reserved.
//

#import "SecondViewController.h"
#import "MessageUI/MessageUI.h"


@interface SecondViewController ()
@end

@implementation SecondViewController
{
    int firstLaunchCounter;
}

-(void)viewDidLoad
{
    [self publicUserMessage];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self firstLaunchUserGuide];
    
    [_storeStoriesbtn setTitle:@"Save" forState:UIControlStateNormal];
}

-(void)viewDidAppear:(BOOL)animated
{
    // auto publish
    [super viewDidAppear:animated];
    
    // when user first launch and save a story
    // add "1" to the badge.
    // when user access SecondViewController, then remove the badge.
    [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:0];

    [self nightModeForKeyCheck];
    
    // show utilities
    _clearDatabtn.hidden = false;
    _customEditbtn.hidden = false;
    _addBreakLinebtn.hidden = false;
    _sendChronicleSMSbtn.hidden = false;
    
    // disable adjustsScroll
    self.automaticallyAdjustsScrollViewInsets = false;


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // creating a forkey if user saves a story on FirstViewController
    // forkey is used to append your saved text into SecondViewController
    // fix for repeating (savedstring) on SecondViewController's viewdidload
    
    // if forkey exist, then append.
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"pathwayappend"])
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // load previous ObjectForKey "savedstring" from firstViewController
        
        NSString *loadstring = [defaults objectForKey:@"savedstring"];
        NSString *loadspace = @"\n";
        NSString *loadseperator = @"___________________________________";
        
        // append users saved data from FirstViewController
        _savedStories.text = [_savedStories.text stringByAppendingString: loadstring];
        // check if user has deactivated the seperator
        if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"SeperatorActivated"])
        {
            _savedStories.text = [_savedStories.text stringByAppendingString:loadseperator];
        }
        _savedStories.text = [_savedStories.text stringByAppendingString: loadspace];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathwayappend"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        

    
    }
    
    else if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"pathwayappendwithname"])
    {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        

        
        // load previous ObjectForKey "savedstring" from firstViewController
        NSString *loadname = [defaults objectForKey:@"savedname"];
        NSString *loadspace = @"\n";
        NSString *loadstring = [defaults objectForKey:@"savedstring"];
        NSString *loadseperator = @"___________________________________";
        
        _savedStories.text = [_savedStories.text stringByAppendingString: loadspace];
        _savedStories.text = [_savedStories.text stringByAppendingString: loadname];
        // check if user has deactivated the seperator
        // if activated, just load space
        if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"SeperatorActivated"])
        {
            _savedStories.text = [_savedStories.text stringByAppendingString: loadspace];
        }
        
        // else load seperator
        else
        {
           _savedStories.text = [_savedStories.text stringByAppendingString:loadseperator];
        }
        _savedStories.text = [_savedStories.text stringByAppendingString: loadstring];
        _savedStories.text = [_savedStories.text stringByAppendingString: loadspace];
        
        // check if user has deactivated the seperator
        if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"SeperatorActivated"])
        {
            _savedStories.text = [_savedStories.text stringByAppendingString:loadseperator];
        }
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathwayappendwithname"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    // else, just load the users previous saved stories in _savedStories
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        // load previous ObjectForKey "savedstring" from firstViewController
        NSString *loadstring = [defaults objectForKey:@"savedstring"];
        NSString *loadname = [defaults objectForKey:@"savedname"];
        
        _savedStories.text = loadname;
        _savedStories.text = loadstring;
        [[NSUserDefaults standardUserDefaults] synchronize];

        // load the count value
    }
    
    [self storeStoriesGlobally];
    
    // check if user has assigned an own value for "add break line" value
    [self customBreaklineTitleForKey];
    
    if(_savedStories.hasText)
    {
        _storeStoriesbtn.enabled = true;
    }
    
    else
    {
        _storeStoriesbtn.enabled = false;
    }
}


// save the SavedStories textView, re-use forKey "savedstring"
- (IBAction)storeStories:(id)sender
{
    [self animatePressedDown:sender duration:0.2 zoom:0.9];
    [self storeStoriesGlobally];

    [_storeStoriesbtn setTitle:@"Saved..." forState:UIControlStateNormal];
}

- (void)storeStoriesGlobally
{
    // stores ObjectForKey "savedstring"
    NSString *loadstring = _savedStories.text;
    NSString *loadname = _savedStories.text;NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:loadname forKey:@"savedname"];
    [defaults setObject:loadstring forKey:@"savedstring"];
    [defaults synchronize];
    
    // re-enable addBreakLinebtn if disabled
    // when user clicks on storeStoriesGlobally"
    // "addBreakLinebtn" will become enabled again
    if (!_addBreakLinebtn.enabled)
    {
        _addBreakLinebtn.enabled = true;
    }
    
    // disable savedStories
    if (_savedStories.editable)
    {
    _savedStories.editable = false;
    }
    
        // disable border after user activated customEdit
        _savedStories.layer.borderWidth = false;
        _savedStories.layer.borderColor = false;
}


-(void)firstLaunchUserGuide
{
    // if user never launched the app before
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunchUserGuideSecond"])
    {
        firstLaunchCounter = 1;
        // show edit image firstlaunch utilities
        _firstLaunchEditImage.alpha = 0;
        _firstLaunchEditLabel.alpha = 0;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _firstLaunchEditImage.alpha = 1;
                             _firstLaunchEditLabel.alpha = 1;
                         }
                         completion:nil];
        _firstLaunchEditImage.hidden = false;
        _firstLaunchEditLabel.hidden = false;

        // hide the rest for now
        _firstLaunchShareImage.hidden = true;
        _firstLaunchShareLabel.hidden = true;
        _firstLaunchWipeImage.hidden = true;
        _firstLaunchWipeLabel.hidden = true;
        _firstLaunchLinebreakImage.hidden = true;
        _firstLaunchLinebreakLabel.hidden = true;
    }
    else
    {
        // hide firstlaunch utilities
        _firstLaunchEditImage.hidden = true;
        _firstLaunchEditLabel.hidden = true;
        _firstLaunchShareImage.hidden = true;
        _firstLaunchShareLabel.hidden = true;
        _firstLaunchWipeImage.hidden = true;
        _firstLaunchWipeLabel.hidden = true;
        _firstLaunchLinebreakImage.hidden = true;
        _firstLaunchLinebreakLabel.hidden = true;
        _firstLaunchContinue.hidden = true;

    }
}

- (IBAction)firstLaunchContinueAction:(id)sender
{
    // step 2, share utilites
    if (firstLaunchCounter == 1)
    {
        _firstLaunchEditImage.hidden = true;
        _firstLaunchEditLabel.hidden = true;
        
        // show
        
        _firstLaunchShareImage.alpha = 0;
        _firstLaunchShareLabel.alpha = 0;
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _firstLaunchShareImage.alpha = 1;
                             _firstLaunchShareLabel.alpha = 1;
                         }
                         completion:nil];
        _firstLaunchShareImage.hidden = false;
        _firstLaunchShareLabel.hidden = false;
        
        firstLaunchCounter = 2;
        
        NSLog(@"share");
    }
    
    // step 3, show wipe
    else if (firstLaunchCounter == 2)
    {
        _firstLaunchShareImage.hidden = true;
        _firstLaunchShareLabel.hidden = true;
        
        // show
        
        _firstLaunchWipeImage.alpha = 0;
        _firstLaunchWipeLabel.alpha = 0;
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _firstLaunchWipeImage.alpha = 1;
                             _firstLaunchWipeLabel.alpha = 1;
                         }
                         completion:nil];
        
        _firstLaunchWipeImage.hidden = false;
        _firstLaunchWipeLabel.hidden = false;
        
        firstLaunchCounter = 3;
        NSLog(@"wipe");
    }
    
    // linebreak
    else if (firstLaunchCounter == 3)
    {
        _firstLaunchShareImage.hidden = true;
        _firstLaunchShareLabel.hidden = true;
        _firstLaunchWipeImage.hidden = true;
        _firstLaunchWipeLabel.hidden = true;
        
        // show
        _firstLaunchLinebreakImage.alpha = 0;
        _firstLaunchLinebreakLabel.alpha = 0;
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _firstLaunchLinebreakImage.alpha = 1;
                             _firstLaunchLinebreakLabel.alpha = 1;
                         }
                         completion:nil];
        _firstLaunchLinebreakImage.hidden = false;
        _firstLaunchLinebreakLabel.hidden = false;
        NSLog(@"share");
        
        [_firstLaunchContinue setTitle:@"Get Started!" forState:UIControlStateNormal];
        firstLaunchCounter = 4;
    }
    
    else if (firstLaunchCounter == 4)
    {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"firstLaunchUserGuideSecond"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // recall method since the object key is now TRUE, hide the elements
        [self firstLaunchUserGuide];
        NSLog(@"RESET");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// disable keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing: true];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)clearData:(id)sender
{
    [self animatePressedDown:sender duration:0.2 zoom:0.9];
    [self clearStoriesAlert];
    
}

-(void)clearStoriesAlert
{
    UIAlertController * alertMessageClear =   [UIAlertController
                                                        alertControllerWithTitle:@"Wipe Saved Stories"
                                                        message:@"Are you sure that you want to wipe your saved stories?"
                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action)
                                {
                                    
                                    [self.tabBarController setSelectedIndex:1];
                                    
                                    // remove keys
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedstory"];
                                    
                                    // replace the savedStories textview none
                                    _savedStories.text = @"";
                                    
                                    // store the the empty textField
                                    // to prevent crashes due empty forKeys on load
                                    NSString *savestring = _savedStories.text; NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; [defaults setObject:savestring forKey:@"savedstring"]; [defaults setObject:savestring forKey:@"savedname"]; [defaults synchronize];
                                    // savedname == savedspace before. if crash change.
                                    
                                    [[NSUserDefaults standardUserDefaults] synchronize];
                                    
                                }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action)
                                    {
                                        [alertMessageClear dismissViewControllerAnimated:YES completion:nil];
                                    }];
    
    [alertMessageClear addAction:confirm];
    [alertMessageClear addAction:cancel];
    [self presentViewController:alertMessageClear animated:YES completion:nil];
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
                                 
                             // call for name change in bottom navbar
                             [self publicUserMessage];
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

// publish story
- (IBAction)publishAction:(id)sender
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"IdentityExists"])
    {
        [self animatePressedDown:sender duration:0.2 zoom:0.9];
        
        
        UIAlertController * alertMessagePublishSuccess =   [UIAlertController
                                                            alertControllerWithTitle:@"4cheer Publish"
                                                            message:@"By confirming, you are agreeing to our terms of service, which can be found at http://www.4cheer.net/terms.html"
                                                            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 
                                 [self publishAnonymouslyAlert];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action)
                                 {
                                     [alertMessagePublishSuccess dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        [alertMessagePublishSuccess addAction:ok];
        [alertMessagePublishSuccess addAction:cancel];
        [self presentViewController:alertMessagePublishSuccess animated:YES completion:nil];
    }
    
    else
    {
        [self createIdentity];
    }

    

}

-(void)publishAnonymouslyAlert
{
    UIAlertController * alertMessagePublishSuccess =   [UIAlertController
                                                        alertControllerWithTitle:@"Publish Anonymously"
                                                        message:@"By posting anonymously, your identity will not appear as a credit for the post when published."
                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* anonymous = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
                             
                             [self showMailFormAnonymously];
                             
                         }];
    UIAlertAction* nonanonymous  = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action)
                             {
                                 [self showMailForm];
                             }];
    
    [alertMessagePublishSuccess addAction:anonymous];
    [alertMessagePublishSuccess addAction:nonanonymous];
    [self presentViewController:alertMessagePublishSuccess animated:YES completion:nil];
}

// SMS composer
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            
            UIAlertController * alertMessageFailed =   [UIAlertController
                    alertControllerWithTitle:@"ERROR"
                    message:@"Message failed."
                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                    actionWithTitle:@"OK"
                    style:UIAlertActionStyleDefault
                    handler:^(UIAlertAction * action)
                    {
                        
                    [alertMessageFailed dismissViewControllerAnimated:YES completion:nil];
                                     
                    }];
            [alertMessageFailed addAction:ok];
            
            [self presentViewController:alertMessageFailed animated:YES completion:nil];
            
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


// before showing the mailform, confirm that the user clicks on "Confirm" on the alertView
-(void)showMailForm
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    NSString *loadidentity = [defaults objectForKey:@"savedidentity"];
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    // Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"New Story 4cheer: %@", loadidentity];
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Story:\n\n\n\n\n\n\rSender ID %@",uniqueIdentifier];
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"publish@4cheer.net"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:false];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:true completion:NULL];
}

// before showing the mailform, confirm that the user clicks on "Confirm" on the alertView
-(void)showMailFormAnonymously
{
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    // Email Subject
    NSString *emailTitle = [NSString stringWithFormat:@"New Story 4cheer (anonymous)"];
    // Email Content
    NSString *messageBody = [NSString stringWithFormat:@"Story:\n\n\n\n\n\n\rSender ID %@",uniqueIdentifier];
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"publish@4cheer.net"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:false];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:true completion:NULL];
}


- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
        {
            UIAlertController * alertMessageSuccess =   [UIAlertController
                alertControllerWithTitle:@"Nice!"
                message:@"Your story has been published for review."
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
            
            // create a forkey which will be removed after 10 minutes
    
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"PublishActionDeactivated"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            

            [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(publishActionEnabled) userInfo:nil repeats:false];
        }
            
            break;
        case MFMailComposeResultFailed:
            
            break;
        default:
            break;
    }
    
    // dismi
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)publicUserMessage
{
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    // if user has created an identity
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"IdentityExists"])
    {
        NSString *loadidentity = [defaults objectForKey:@"savedidentity"];
        _bottomNavigation.topItem.title = [NSString stringWithFormat:@"%@", loadidentity];
    }
    
    else
    {
        NSInteger RandomUserIdentityFetch = [[[NSUserDefaults standardUserDefaults] objectForKey:@"RandomUserIdentity"] intValue];
        _bottomNavigation.topItem.title = [NSString stringWithFormat:@"User%ld", (long)RandomUserIdentityFetch];
    }
    
}

// send SMS with message of savedStories textView
- (IBAction)sendChronicleSMS:(id)sender
{
    NSString *shareText = [NSString stringWithFormat:@"Sent with 4cheer. The unique storyteller app for iPhone! Download it here: http://4cheer.net \n\n%@", _savedStories.text];
    NSArray *itemsToShare = @[shareText];
    UIActivityViewController *activityCV = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityCV.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard];
    
    [self presentViewController:activityCV animated:true completion:nil];
    
    // create a forkey to add "sent with 4cheer" message
    // when mail/sms is sent. Remove the forkey.
        
    
    
}

- (IBAction)customEdit:(id)sender
{
    // make SavedStories editable for the user onclick
    _savedStories.editable = true;
    
    // method for enabling storeStories btn if savedStories is empty ...
    [self textFieldDidBeginEditing:_savedStories];
    
    // add easing borders to SavedStories for the user to notice. When SaveStories onclick, remove borders
    _savedStories.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _savedStories.alpha = 1;}
                     completion:nil];
    
    _savedStories.layer.borderWidth = 0.8f;
    _savedStories.layer.borderColor = [[UIColor grayColor] CGColor];
    
    // change title of button
    [_storeStoriesbtn setTitle:@"Done" forState:UIControlStateNormal];
}

// basically used when the users savedstories is empty and the user cant save the editing that was made, because the btn is disabled when the textView is empty due spamm etc.
-(void)textFieldDidBeginEditing:(UITextView *)textView
{
    if(!_storeStoriesbtn.enabled)
    {
        _storeStoriesbtn.enabled = true;
    }
    NSLog(@"EDITABLE");
}


- (IBAction)addBreakLine:(id)sender
{
    [self animatePressedDown:sender duration:0.2 zoom:0.9];
    // first append blankspace to exclude the breakline to appear mid section
    [self customBreakLineForKeyCheck];
    _storeStoriesbtn.enabled = true;
}


- (void)customBreakLineForKeyCheck
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"BreaklineDefaultActivated"])
    {
        
        _savedStories.text = [_savedStories.text stringByAppendingString:@"\n"];
        // append break line to SavedStories
        _savedStories.text = [_savedStories.text stringByAppendingString:@"_____________________"];
        
        // disable button until user clicks on SaveStories
        ((UIButton *)_addBreakLinebtn).enabled = false;
        
        // change title of button
        [_storeStoriesbtn setTitle:@"Done" forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        
        NSString *loadownvalue = [defaults objectForKey:@"owntextvalue"];
        
        _savedStories.text = [_savedStories.text stringByAppendingString:@"\n"];

        _savedStories.text = [_savedStories.text stringByAppendingString: loadownvalue];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // change title of button
        [_storeStoriesbtn setTitle:@"Done" forState:UIControlStateNormal];
        
        // disable button until user clicks on SaveStories
        ((UIButton *)_addBreakLinebtn).enabled = false;
    }
    
    
}

-(void)customBreaklineTitleForKey
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"BreaklineDefaultActivated"])
    {
       [_addBreakLinebtn setTitle:@"Add line break" forState:UIControlStateNormal];
    }
    else
    {
        [_addBreakLinebtn setTitle:@"Add custom value" forState:UIControlStateNormal];
        
    }
}


- (void)nightModeForKeyCheck
{
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"NightModeActivated"])
    {
        
        [self nightModeActivated];
    }
}

- (void)nightModeActivated
{
    self.view.backgroundColor = [UIColor blackColor];
    _savedStories.textColor = [UIColor whiteColor];
}
@end

