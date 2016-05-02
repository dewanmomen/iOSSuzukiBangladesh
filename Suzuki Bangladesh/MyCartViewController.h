//
//  MyCartViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *cartTable;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSpareTabWidth;



@property (weak, nonatomic) IBOutlet UILabel *lblspareIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblCartIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblSpareText;
@property (weak, nonatomic) IBOutlet UILabel *lblCartText;

@property (weak, nonatomic) IBOutlet UIView *spareUIView;
@property (weak, nonatomic) IBOutlet UIView *cartUIView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrQtyWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrItemWidth;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;

- (IBAction)sideBarButtonMenuShow:(id)sender;
- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;


@end
