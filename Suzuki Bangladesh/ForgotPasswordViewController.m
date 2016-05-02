//
//  ForgotPasswordViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "ForgotPasswordViewController.h"

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

@implementation ForgotPasswordViewController{
    CGFloat animatedDistance;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.resetButtton.layer.borderWidth = 1.0;
    self.resetButtton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.resetButtton.layer.cornerRadius = 6.0;
    
    self.txtEmail.delegate = self;
}

- (IBAction)resetAction:(id)sender {
    
    NSDictionary *parameters = @{key_forget_pass_auth_key: [GlobalInstance sharedInstance].auth_key,
                                 key_forget_pass_user_id: [GlobalInstance sharedInstance].user_id,
                                 key_forget_pass_user_email: self.txtEmail.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys forgetPassURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setForgotPasswordJSON:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[GlobalInstance sharedInstance].forgotPasswordJSON status]) {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Password Have Been Successfully Reset"
                                               subtitle:[[GlobalInstance sharedInstance].forgotPasswordJSON message]
                                                   type:TSMessageNotificationTypeSuccess];
            
        } else {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Password Reset Failed !"
                                               subtitle:[[GlobalInstance sharedInstance].forgotPasswordJSON message]
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
