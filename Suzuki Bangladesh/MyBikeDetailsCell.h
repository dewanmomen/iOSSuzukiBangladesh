//
//  MyBikeDetailsCell.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/13/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBikeDetailsCell : UITableViewCell

@end

@interface BDCategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *category;

@end

@interface BDSpecCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *spec_title;
@property (weak, nonatomic) IBOutlet UILabel *spec_value;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrSpecTitleWidth;

@end

@interface BDSeperatorCell : UITableViewCell


@end