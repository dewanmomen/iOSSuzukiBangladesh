//
//  ChangePasswordViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "NSDictionary+ChangePassword.h"
#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import "TSMessage.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation ChangePasswordViewController{
    CGFloat animatedDistance;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.changePassButton.layer.borderWidth = 1.0;
    self.changePassButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.changePassButton.layer.cornerRadius = 6.0;
    
    self.txtOldPassword.delegate = self;
    self.txtNewPassword.delegate = self;
    self.textConfNewPassword.delegate = self;
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

- (IBAction)changePassAction:(id)sender {
    
    if (![self.txtNewPassword.text isEqualToString:self.textConfNewPassword.text]) {
        [TSMessage showNotificationInViewController:self
                                              title:@"Password Mismatch !"
                                           subtitle:@"Your new passwords don't match."
                                               type:TSMessageNotificationTypeError];
    } else {
        
        NSDictionary *parameters = @{key_change_pass_auth_key: [GlobalInstance sharedInstance].auth_key,
                                     key_change_pass_old_password: self.txtOldPassword.text,
                                     key_change_pass_user_id: [GlobalInstance sharedInstance].user_id,
                                     key_change_pass_new_password:self.txtNewPassword.text};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [manager POST:[APIURLsNdKeys changePassURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [[GlobalInstance sharedInstance] setChangePasswordJSON:responseObject];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if ([[GlobalInstance sharedInstance].changePasswordJSON status]) {
                [TSMessage showNotificationInViewController:self
                                                      title:@"Password Successfully Changed"
                                                   subtitle:[[GlobalInstance sharedInstance].changePasswordJSON message]
                                                       type:TSMessageNotificationTypeSuccess];
                
            } else {
                [TSMessage showNotificationInViewController:self
                                                      title:@"Password Change Failed !"
                                                   subtitle:[[GlobalInstance sharedInstance].changePasswordJSON message]
                                                       type:TSMessageNotificationTypeError];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [TSMessage showNotificationInViewController:self
                                                  title:@"Error Retrieving Data"
                                               subtitle:[error localizedDescription]
                                                   type:TSMessageNotificationTypeError];
        }];
    }
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
@end
