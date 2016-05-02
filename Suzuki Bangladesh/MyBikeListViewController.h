//
//  MyBikeListViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/12/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface MyBikeListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bikeListTable;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;

- (IBAction)sideBarButtonMenuShow:(id)sender;
- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;

@end
