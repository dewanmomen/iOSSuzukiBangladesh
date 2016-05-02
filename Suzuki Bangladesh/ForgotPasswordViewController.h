//
//  ForgotPasswordViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *resetButtton;

- (IBAction)resetAction:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *txtEmail;


@end
