//
//  MyBikeListViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/12/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "MyBikeListViewController.h"
#import "MyBikeDetailsViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "MyBikeListCell.h"
#import "NSDictionary+BikeList.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import "UIImageView+AFNetworking.h"
#import <AFNetworking+ImageActivityIndicator/AFNetworking+ImageActivityIndicator.h>

#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyBikeListViewController{
    NSArray *allBikes;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"Im here");
    allBikes = [[GlobalInstance sharedInstance].bikeListJSON bikeList];
    [self getMyBikeListData];
    
    [self setUpTheNavBar];
}

- (void)setUpTheNavBar{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:font_suzuki_regular size:21]}];
    
    [self.sideBarMenu setTitleTextAttributes:@{
                                               NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]
                                               } forState:UIControlStateNormal];
    [self.sideBarMenu setTitle:@"\uf0c9"];
    
    [self.navBarNotifButton setTitleTextAttributes:@{
                                                     NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                                     } forState:UIControlStateNormal];
    [self.navBarNotifButton setTitle:@"\uf0a2"];
    
    [self.navBarMapButton setTitleTextAttributes:@{
                                                   NSFontAttributeName: [UIFont fontWithName:font_font_awesome_yay size:18.0],
                                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                                   } forState:UIControlStateNormal];
    [self.navBarMapButton setTitle:@"\uf041"];
    
    self.navBarNotifButton.badgeBGColor = [UIColor colorWithRed:253/255.0 green:176/255.0 blue:15/255.0 alpha:1.0];
    self.navBarNotifButton.badgeTextColor = [UIColor whiteColor];
    self.navBarNotifButton.badgeFont = [UIFont fontWithName:font_suzuki_regular size:11.0];
    self.navBarNotifButton.badgePadding = 1.0;
    self.navBarNotifButton.badgeOriginX = 12.0;
    self.navBarNotifButton.badgeOriginY = 2.0;
    self.navBarNotifButton.badgeValue = @"14";
    
}
- (void) getMyBikeListData{
    NSDictionary *parameters = @{key_getMyBikeList_authKey: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys getMyBikeListURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [[GlobalInstance sharedInstance] setBikeListJSON:responseObject];
        allBikes = [[GlobalInstance sharedInstance].bikeListJSON bikeList];
        //NSLog(@"Bike Array size: %i", [allBikes count]);
        self.bikeListTable.delegate = self;
        self.bikeListTable.dataSource = self;
        [self.bikeListTable reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [allBikes count]; // in your case, there are 3 cells
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.; // you can have your own choice, of course
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"inside cellforrowatindex");
    //NSLog(@"from cellforrowatindex %i", count);
    float thatWidth = ([[UIScreen mainScreen]bounds].size.width - 20) / 3.0;
    Bike* bike = [allBikes objectAtIndex:indexPath.section];
        
    NSString *CellIdentifier = @"myBikeListCell";
    MyBikeListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.constrTheVerticalViewLeadingSpaceFromSuperView.constant = thatWidth;
    cell.constrNameBGViewWidth.constant = thatWidth;
    //[cell.nameBGView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bike_name_bg.png"]]];
    [cell.bikeName setText:bike.bike_name];
    [cell.engineCC setText:[NSString stringWithFormat:@"%@", bike.bike_cc]];
    [cell.mileageValue setText:[NSString stringWithFormat:@"%@", bike.bike_mileage]];

    [cell.bikeImage setClipsToBounds:YES];
    //[cell.bikeImage setImageWithURL:[NSURL URLWithString:@"http://www.mtb-downhill.net/wp-content/uploads/2013/01/south-crew-friends-mountain-bike.jpg"]];
    [cell.bikeImage setImageWithURL:[NSURL URLWithString:bike.thumble_img] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    cell.clipsToBounds = NO;
    cell.layer.masksToBounds = NO;
    CGRect shadowFrame = cell.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    CALayer *viewLayer = cell.layer;
    viewLayer.shadowPath = shadowPath;
    viewLayer.shadowOffset = CGSizeMake(4, 2);
    viewLayer.shadowColor = [[UIColor lightGrayColor] CGColor];
    viewLayer.shadowRadius = 1;
    viewLayer.shadowOpacity = 0.70;
    
    //[cell addShadowToCellInTableView:tableView atIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    MyBikeDetailsViewController* bd = (MyBikeDetailsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "bikeDetailsScene"];
    bd.bike_id = ((Bike*)[allBikes objectAtIndex:indexPath.row]).bike_id;
    
    [self.navigationController pushViewController:bd animated:YES];
}

- (IBAction)sideBarButtonMenuShow:(id)sender {
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
}
- (IBAction)navBarNotifButtonAction:(id)sender {
    
    NotificationListViewController* notificationViewController = (NotificationListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "notificationListScene"];
    [self.navigationController pushViewController:notificationViewController animated:YES];
}

- (IBAction)navBarMapAction:(id)sender {
}

@end
