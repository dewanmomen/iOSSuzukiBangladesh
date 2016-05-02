//
//  RFSViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/24/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REFrostedViewController.h"

@interface RFSViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewParts;

@property (weak, nonatomic) IBOutlet UILabel *lblDownArrow;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrFreeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrPaidWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSubmitWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrPartsChangeWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrRepairWidth;


@property (weak, nonatomic) IBOutlet UILabel *freeRadio;
@property (weak, nonatomic) IBOutlet UILabel *freeText;
@property (weak, nonatomic) IBOutlet UILabel *paidRadio;
@property (weak, nonatomic) IBOutlet UILabel *paidText;
@property (weak, nonatomic) IBOutlet UILabel *warrantyRadio;
@property (weak, nonatomic) IBOutlet UILabel *warrantyText;


@property (weak, nonatomic) IBOutlet UITextView *txtComment;

@property (weak, nonatomic) IBOutlet UIButton *bikeModelButton;
- (IBAction)bikeModelAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet UIButton *partsChange;
- (IBAction)partsChangeAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *repair;
- (IBAction)repairAction:(id)sender;


- (IBAction)submitAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarNotifButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navBarMapButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarMenu;

- (IBAction)sideBarButtonMenuShow:(id)sender;
- (IBAction)navBarNotifButtonAction:(id)sender;
- (IBAction)navBarMapAction:(id)sender;

@end
