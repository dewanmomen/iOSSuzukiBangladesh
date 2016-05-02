//
//  RFQViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/21/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "RFQViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "MyBikeDetailsCell.h"
#import "NSDictionary+BikeDetails.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import <QuartzCore/QuartzCore.h>


static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@implementation RFQViewController{
    CGFloat animatedDistance;
}

@synthesize bike_id, bike_name, bike_cc;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.constrBikeNameWidth.constant = [UIScreen mainScreen].bounds.size.width * .55;
    
    [self.lblBikeName setText:bike_name];
    [self.lblBikeCC setText:[NSString stringWithFormat:@"%@ CC", bike_cc]];
    
    self.lblBikeName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lblBikeName.layer.borderWidth = 2.0;
    
    self.lblBikeCC.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.lblBikeCC.layer.borderWidth = 2.0;
    
    self.txtComment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtComment.layer.borderWidth = 2.0;
    
    self.txtEmail.delegate = self;
    self.txtName.delegate = self;
    self.txtAddress.delegate = self;
    self.txtCellNo.delegate = self;
    [self.txtComment setDelegate:self];
    
}

- (IBAction)actionSubmit:(id)sender {
    
    NSDictionary *parameters = @{key_rfq_auth_key: [GlobalInstance sharedInstance].auth_key,
                                 key_rfq_app_user_name: self.txtName.text,
                                 key_rfq_bike_id: bike_id,
                                 key_rfq_bike_name: bike_name,
                                 key_rfq_app_user_email: self.txtEmail.text,
                                 key_rfq_app_user_phone: self.txtCellNo.text,
                                 key_rfq_app_user_address: self.txtAddress.text,
                                 key_rfq_app_user_comment: self.txtComment.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys rfqURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [[GlobalInstance sharedInstance] setRfqJSON:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if ([[GlobalInstance sharedInstance].rfqJSON status]) {
            [TSMessage showNotificationWithTitle:@"Quotation Request Sent"
                                        subtitle:[[GlobalInstance sharedInstance].rfqJSON message]
                                            type:TSMessageNotificationTypeSuccess];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [TSMessage showNotificationWithTitle:@"Failed !"
                                        subtitle:[[GlobalInstance sharedInstance].rfqJSON message]
                                            type:TSMessageNotificationTypeError];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationWithTitle:@"Error Retrieving Data"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
        
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)]];
    
    
    CGRect textFieldRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
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

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
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
