//
//  FirstViewController.m
//  Chronicle Vision
//
//  Created by Jimmie Magnusson on 2016-07-23.
//  Copyright © 2016 Jimmie Magnusson. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@end

@implementation FirstViewController

-(void)viewDidAppear:(BOOL)animated
{
    [self firstUserLaunchAppear];
}

-(void)identityExists
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"IdentityExists"])
    {
        NSString *loadidentity = [defaults objectForKey:@"savedidentity"];
        _navigationBar.topItem.title = [NSString stringWithFormat:@"Welcome back, %@", loadidentity];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"pathwayload"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self nightModeForKeyCheck];
    [self firstUserLaunch];
    // check hide label until randomStory button is clicked
    // onclick will call for a method checking if its users first launch
    _detailSaveLabel.hidden = true;
    _detailFirstSaveLabel.hidden = true;
    _detailSaveLongPressureLabel.hidden = true;
        
    // boolean for first view
    _storyLabel.hidden = true;
    _storyLabel.editable = false;
    _saveStorybtn.hidden = true;
    
    // check if user has created an identity
    [self identityExists];

}


// memory
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

// button
- (IBAction)randomStory:(id)sender
{
    [self fetchRandomStory];

}

// gesture
- (IBAction)randomStorySwipeGesture:(id)sender
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"GestureSwipeActivated"])
    {
        [self fetchRandomStory];
    }
}

- (void)fetchRandomStory
{
    [self viewDidLoad];
    [self animatePressedDown:_randomStory duration:0.2 zoom:0.9];
    _storyLabel.hidden = false;
    [_saveStorybtn setTitle:@"Save this chronicle" forState:UIControlStateNormal];
    _saveStorybtn.hidden = false;
    
    // animate storyLabel, saveStoryimg & saveStorybtn as fade in
    _storyLabel.alpha = 0;
    _saveStorybtn.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{ _storyLabel.alpha = 1;
                         _saveStorybtn.alpha = 1;}
                     completion:nil];
    
    
    // declare randomStory as int
    int randomStory;
    
    // declare storyString as string
    NSString *storyString;
    
    // create variables for text file
    
    // get chronices from text file name
    NSString *title = @"chronicles";
    // attribute name
    NSString *type = @"txt";
    // seperation
    NSString *separation = @"____________________________________________";
    // encoding and variable
    NSString *fileText = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:title ofType:type] encoding:NSUTF8StringEncoding error:nil];
    
    // create array with seperated text by \n
    NSMutableArray *storyArray = [[NSMutableArray alloc]initWithArray:[fileText componentsSeparatedByString:separation]];
    
    
    // randomize one text from the text file
    randomStory = arc4random()%[storyArray count];
    
    storyString = [storyArray objectAtIndex: randomStory];
    // output in storyLabel textView
    _storyLabel.text
    = storyString;
    
    // if user clicks on "save story" then disable the button until user randomizes a new story
    // preventing spam
    if (!_saveStorybtn.enabled)
    {
    _saveStorybtn.enabled = true;
    }
    
    // call for method
    // if users first launch
    [self firstUserLaunch];
}


// normal save story
- (IBAction)saveStory:(id)sender
{
    [self animatePressedDown:sender duration:0.2 zoom:0.6];
    // disable button until user randomizes a new story
    _saveStorybtn.enabled = false;
    
    NSString *savestring = _storyLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // create the forKey's
    [defaults setObject:savestring forKey:@"savedstring"];
    [defaults synchronize];
    
    // if users first launch
    // hide detail label
    _detailSaveLabel.hidden = true;
    // onclick change title of button
    
    
    // creating a forkey if user saves a story
    // forkey is used to append your saved text into SecondViewController
    // fix for repeating (savedstring) on SecondViewController's viewdidload
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"pathwayappend"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // call for method if users first launch
    [self displayUserInterface];
}

// if user holds the normal save story
// show input for naming the story
- (IBAction)saveStoryLongPress:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"4cheer"
                                  message:@"Name this story"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
    {
                                                   
                    UITextField *alertTextField = alert.textFields.firstObject;
        
                    NSString *savename = alertTextField.text;
                                                   
                    NSString *savestring = _storyLabel.text;
                                                   
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    // create the forKey's
                    [defaults setObject:savename forKey:@"savedname"];
                    [defaults setObject:savestring forKey:@"savedstring"];
                    [defaults synchronize];
                                                   
                    // if users first launch
                    // hide detail label
                    // [self displayUserInterface]; will be ran below,which changes the boolean if user has or has not launched the app before
                    _detailSaveLabel.hidden = true;
                                                   
                    // when user has clicked save, input string in textField to let the user know that the story has been saved
                                                   
                    // if user saves a story normally and don't view it in SecondViewController which results in forKey "pathwayappend" is still active
                                                   // remove the forkey "pathwayappend" and then create a new one
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pathwayappend"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                                                   
                    // creating a forkey if user saves a story
                    // forkey is used to append your saved text into SecondViewController
                    // fix for repeating (savedstring) and (savedname) on SecondViewController's viewdidload
                    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"pathwayappendwithname"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                                                   
                    // call for method if users first launch
                    [self displayUserInterface];
                                                   
                    // disable button until user randomizes a new story
                    _saveStorybtn.enabled = false;
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name of story";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];

}


// disable keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:true];
    }
    [super touchesBegan:touches withEvent:event];
}

// alert only
-(void)firstUserLaunchAppear
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasPerformedFirstLaunch"])
    {
        UIAlertController * alertMessageFirstLaunch =   [UIAlertController
            alertControllerWithTitle:@"Welcome to 4cheer"
            message:@"By continuing you agree to our terms of service: http://4cheer.net/terms.html/"
            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
    actionWithTitle:@"Continue"
    style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action)
    {
                             
    [alertMessageFirstLaunch dismissViewControllerAnimated:YES completion:nil];
                             
    }];
    [alertMessageFirstLaunch addAction:ok];
    
    [self presentViewController:alertMessageFirstLaunch animated:YES completion:nil];
    }
}

// see if the user has launched the app before
// called when user clicks on Randomize Story
-(void)firstUserLaunch
{
    // if user never launched the app before
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasPerformedFirstLaunch"])
    {
        
        _detailSaveLabel.hidden = false;
        _detailSaveLongPressureLabel.hidden = false;
        
        // if user never saved stories then NSUserDefault is null
        // then the app will crash instantly if enter secondViewController
        
        // fill the NSuserDefault onload before entering secondViewController
        // apply empty strings to forKeys
        NSString *saveemptystring = @"";
        NSString *saveemptyspace = @"";
        NSUserDefaults *emptykeys = [NSUserDefaults standardUserDefaults];
        // create the forKeys
        [emptykeys setObject:saveemptystring forKey:@"savedstring"];
        [emptykeys setObject:saveemptyspace forKey:@"savedspace"];
        // synchronize the forKeys
        [emptykeys synchronize];
        
        // set "seperator" by saved stories as default when user first opens the app
        // can be deactivated in settings later.
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"SeperatorActivated"];
        
        // create a forkey for default breakline
        // if the user enters Settings and deactivates this option, the forkey will be removed.
        // if user go back and activates it, a forkey will be created.
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"BreaklineDefaultActivated"];
        
        // may miss synch
        
        int randomUserIdentity = arc4random()%899 + 100;
        [[NSUserDefaults standardUserDefaults] setInteger:randomUserIdentity forKey:@"RandomUserIdentity"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// child to usersFirstLaunch
// when Save story button is pressed
- (void)displayUserInterface
{
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"hasPerformedFirstLaunch"])
    {
        _detailFirstSaveLabel.hidden = true;
        _detailSaveLongPressureLabel.hidden = true;
        // next time user launches the app, dont show any number in badge.
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:0];


    }
    
    else
    {
        _detailFirstSaveLabel.hidden = false;
        _detailSaveLongPressureLabel.hidden = false;
        _detailSaveLabel.hidden = true;
        
        [[self.tabBarController.tabBar.items objectAtIndex:1] setBadgeValue:@"1"];
        // set the "hasPerformedFirstLaunch" key so this block won't execute again
        [[NSUserDefaults standardUserDefaults] setBool: true forKey:@"hasPerformedFirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

- (void)nightModeForKeyCheck
{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:@"NightModeActivated"]){
        
        [self nightModeActivated];
    }

    else
    {
        [self nightModeDeactivated];
    }
}


// apply night mode
- (void)nightModeActivated
{
    // background
    self.view.backgroundColor = [UIColor blackColor];
    
    // story text
    _storyLabel.textColor = [UIColor whiteColor];
}

// reset to standard values
// some elements from [self nightModeActivated]
// doesn't need reset onload, it resets itself.
- (void)nightModeDeactivated
{
    self.view.backgroundColor = [UIColor whiteColor];
    _storyLabel.textColor = [UIColor blackColor];
}





@end
