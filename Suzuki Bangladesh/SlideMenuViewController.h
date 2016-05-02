//
//  SlideMenuViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 3/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface SlideMenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UILabel *labelSignInSignOut;

@end
