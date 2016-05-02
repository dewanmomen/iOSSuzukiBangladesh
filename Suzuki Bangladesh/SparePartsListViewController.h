//
//  SpartPartsList.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SparePartsListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *spareTable;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSpareTabWidth;



@property (weak, nonatomic) IBOutlet UILabel *lblspareIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblCartIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblSpareText;
@property (weak, nonatomic) IBOutlet UILabel *lblCartText;

@property (weak, nonatomic) IBOutlet UIView *spareUIView;
@property (weak, nonatomic) IBOutlet UIView *cartUIView;

@property (weak, nonatomic) IBOutlet UILabel *lblSearchIcon;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchQuery;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;

- (IBAction)sideBarButtonMenuShow:(id)sender;
- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;

@end
