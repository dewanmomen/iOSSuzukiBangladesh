//
//  PromotionViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface PromotionViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *promotionImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrDetailImageHeight;

@property (weak, nonatomic) IBOutlet UILabel *detailTitle;

@property (weak, nonatomic) IBOutlet UITextView *detailsDesc;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;

- (IBAction)sideBarButtonMenuShow:(id)sender;
- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;


@end
