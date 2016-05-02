//
//  SparePartsCell.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SparePartsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrFirstVerticalViewLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSecondVerticalViewLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrPartsNameViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *costrBikeNameWidth;


@property (weak, nonatomic) IBOutlet UILabel *lblPartsName;
@property (weak, nonatomic) IBOutlet UILabel *lblBikeName;
@property (weak, nonatomic) IBOutlet UILabel *lblPartsModelOr;
@property (weak, nonatomic) IBOutlet UILabel *lblPartsPrice;

@property (weak, nonatomic) IBOutlet UILabel *lblCartIcon;
@property (weak, nonatomic) IBOutlet UIImageView *imgPartsImage;

@end
