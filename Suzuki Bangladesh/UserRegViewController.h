//
//  UserRegViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/20/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserRegViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

@property (weak, nonatomic) IBOutlet UITextField *txtaddress;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtThana;


@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

- (IBAction)registerAction:(id)sender;
@end
