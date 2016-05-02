//
//  MyBikeDetailsViewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/13/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBikeDetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *bikedetailTable;
@property (nonatomic, strong) NSString* bike_id;

- (IBAction)quoteButton:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *lblBikeCC;


@property (weak, nonatomic) IBOutlet UILabel *lblBikeName;


@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;


@property (weak, nonatomic) IBOutlet UIView *colorLabelView;


@property (weak, nonatomic) IBOutlet UIView *headerView;



@end


@interface BikeImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgBikeImage;
@end


@interface UIView (Animation)
- (void)addSubviewWithBounce:(UIView*)theView;
@end