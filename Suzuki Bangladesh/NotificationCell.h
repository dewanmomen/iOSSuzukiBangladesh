//
//  NotificationCell.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (weak, nonatomic) IBOutlet UILabel *myTitle;

@property (weak, nonatomic) IBOutlet UILabel *myDesctiption;

@property (weak, nonatomic) IBOutlet UILabel *notificationType;
@end
