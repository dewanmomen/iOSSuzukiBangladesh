//
//  MyBikeListCell.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/12/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBikeListCell : UITableViewCell

//- (void)addShadowToCellInTableView:(UITableView *)tableView
//                       atIndexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) IBOutlet UIImageView *bikeImage;

@property (weak, nonatomic) IBOutlet UIView *theVerticalView;

@property (weak, nonatomic) IBOutlet UILabel *engineCC;

@property (weak, nonatomic) IBOutlet UILabel *mileageValue;

@property (weak, nonatomic) IBOutlet UIView *nameBGView;

@property (weak, nonatomic) IBOutlet UILabel *bikeName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrNameBGViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrTheVerticalViewLeadingSpaceFromSuperView;

@end
