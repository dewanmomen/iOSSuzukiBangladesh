//
//  NewsNdEventCell.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsNdEventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UILabel *myDescription;
@property (weak, nonatomic) IBOutlet UILabel *newsOrEven;

@end
