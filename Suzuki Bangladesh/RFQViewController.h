//
//  RFQViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/21/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFQViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSString* bike_id;
@property (nonatomic, strong) NSString* bike_name;
@property (nonatomic, strong) NSString* bike_cc;

@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtAddress;

@property (weak, nonatomic) IBOutlet UITextField *txtCellNo;

@property (weak, nonatomic) IBOutlet UILabel *lblBikeName;

@property (weak, nonatomic) IBOutlet UILabel *lblBikeCC;

@property (weak, nonatomic) IBOutlet UITextView *txtComment;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrBikeNameWidth;

- (IBAction)actionSubmit:(id)sender;
@end
