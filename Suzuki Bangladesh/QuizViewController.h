//
//  QuizViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/9/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface QuizViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (IBAction)sideBarButtonMenuShow:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *timer;

@property (weak, nonatomic) IBOutlet UITableView *quizTable;
@property (weak, nonatomic) IBOutlet UILabel *quizTile;

- (IBAction)nextButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;


- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;

//@property (weak, nonatomic) IBOutlet UILabel *label;
//- (IBAction)toggle:(id)sender;

@end
