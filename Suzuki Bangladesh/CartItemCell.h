//
//  CartItemCell.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartItemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrItemCellFirstLeading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrItemCellSecondLeading;


@property (weak, nonatomic) IBOutlet UILabel *lblQty;

@property (weak, nonatomic) IBOutlet UILabel *lblPartsName;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;


@end
