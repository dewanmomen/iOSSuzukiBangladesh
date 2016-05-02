//
//  LogInViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/20/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "LogInViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "NSDictionary+UserLogIn.h"
#import "UserRegViewController.h"
#import "ForgotPasswordViewController.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

#import "NavigationController.h"
#import "HomeViewController.h"

#import <QuartzCore/QuartzCore.h>

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation LogInViewController{
    CGFloat animatedDistance;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.logInIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
    [self.logInIcon setText:@"\uf090"];
    
    self.logInView.layer.borderWidth = 1.0;
    self.logInView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.logInView.layer.cornerRadius = 6.0;
    
    [self.logInView setUserInteractionEnabled:YES];
    [self.logInView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction)]];
    
    NSLog(@"login url: %@, auth key: %@", [APIURLsNdKeys userLogInURL], [GlobalInstance sharedInstance].auth_key);
    
    self.txtEmail.delegate = self;
    self.txtPass.delegate = self;
    
    [self setUpTheNavBar];
}

- (void)setUpTheNavBar{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:font_suzuki_regular size:21]}];
    
    [self.sideBarMenu setTitleTextAttributes:@{
                                               NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]
                                               } forState:UIControlStateNormal];
    [self.sideBarMenu setTitle:@"\uf0c9"];
    
    [self.navBarNotifButton setTitleTextAttributes:@{
                                                     NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                     } forState:UIControlStateNormal];
    [self.navBarNotifButton setTitle:@"\uf0a2"];
    
    [self.navBarMapButton setTitleTextAttributes:@{
                                                   NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                                   } forState:UIControlStateNormal];
    [self.navBarMapButton setTitle:@"\uf041"];
    
    self.navBarNotifButton.badgeBGColor = [UIColor colorWithRed:253/255.0 green:176/255.0 blue:15/255.0 alpha:1.0];
    self.navBarNotifButton.badgeTextColor = [UIColor whiteColor];
    self.navBarNotifButton.badgeFont = [UIFont fontWithName:font_suzuki_regular size:11.0];
    self.navBarNotifButton.badgePadding = 1.0;
    self.navBarNotifButton.badgeOriginX = 12.0;
    self.navBarNotifButton.badgeOriginY = 2.0;
    self.navBarNotifButton.badgeValue = @"14";
    
}

- (void)loginAction {
    
    NSDictionary *parameters = @{key_userLogIn_auth_key: [GlobalInstance sharedInstance].auth_key,
                                 key_userLogIn_user_email: self.txtEmail.text,
                                 key_userLogIn_user_pass: self.txtPass.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys userLogInURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setUserLogInJSON:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[GlobalInstance sharedInstance].userLogInJSON status]) {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Login Sucessful."
                                               subtitle:[[GlobalInstance sharedInstance].userLogInJSON message]
                                                   type:TSMessageNotificationTypeSuccess];
            
            
            [GlobalInstance sharedInstance].isLoggedin = [[GlobalInstance sharedInstance].userLogInJSON status];
            [GlobalInstance sharedInstance].user_id = [[GlobalInstance sharedInstance].userLogInJSON user_id];
            
            [[NSUserDefaults standardUserDefaults] setObject:[[GlobalInstance sharedInstance].userLogInJSON user_id] forKey:STRING_USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:IS_LOGGED_IN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
            HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeScene"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            
        } else {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Login Failed !"
                                               subtitle:[[GlobalInstance sharedInstance].userLogInJSON message]
                                                   type:TSMessageNotificationTypeError];
            
            [GlobalInstance sharedInstance].isLoggedin = [[GlobalInstance sharedInstance].userLogInJSON status];
            [GlobalInstance sharedInstance].user_id = nil;
            
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:STRING_USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:IS_LOGGED_IN];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //NSLog(@"Error %@", error);
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
        
        [GlobalInstance sharedInstance].isLoggedin = false;
        [GlobalInstance sharedInstance].user_id = nil;
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:STRING_USER_ID];
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:IS_LOGGED_IN];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
    }];
    
    
    
}


- (IBAction)sideBarButtonMenuShow:(id)sender {
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
}
- (IBAction)navBarNotifButtonAction:(id)sender {
    
    NotificationListViewController* notificationViewController = (NotificationListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "notificationListScene"];
    [self.navigationController pushViewController:notificationViewController animated:YES];
}

- (IBAction)navBarMapAction:(id)sender {
}



- (IBAction)forgotPasswordAction:(id)sender {
    
    ForgotPasswordViewController* fp = (ForgotPasswordViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "forgotPasswordScene"];
    
    [self.navigationController pushViewController:fp animated:YES];
    
}

- (IBAction)signUpAction:(id)sender {
    
    UserRegViewController* ur = (UserRegViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "userRegScene"];
    
    [self.navigationController pushViewController:ur animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)]];
    
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
    return YES;
}

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [self.view endEditing:YES];
    [self.view removeGestureRecognizer:tapRecognizer];
    
}

@end
