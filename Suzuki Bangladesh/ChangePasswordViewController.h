//
//  ChangePasswordViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *changePassButton;

- (IBAction)changePassAction:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *txtOldPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;

@property (weak, nonatomic) IBOutlet UITextField *textConfNewPassword;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;

- (IBAction)sideBarButtonMenuShow:(id)sender;
- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;

@end
