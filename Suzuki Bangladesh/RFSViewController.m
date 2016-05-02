//
//  RFSViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/24/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "RFSViewController.h"

#import "RFSPartsNameCell.h"
#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import <QuartzCore/QuartzCore.h>

#import "NSDictionary+Rfs.h"
#import "NSDictionary+BikeList.h"

#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

@implementation RFSViewController{
    NSArray *parts;
    UIView* bikeModelView;
    NSArray* bikes;
    UITableView* bikeModelTable;
    
    NSMutableArray* serviceOption;
    NSString* serviceType;
    NSString* servicingType;
    //NSString* selectedBike;
    Bike* selectedBikeObject;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    parts = [[NSArray alloc] initWithObjects:@"ENGINE", @"ELECTRICAL", @"SUSPENSION",@"WHEEL / TYRE", @"BREAK", @"SPEEDO METER", @"GEAR", @"CLUTCH PLATE", @"OIL FILTER", @"BODY PARTS", nil];
    
    bikes = [[GlobalInstance sharedInstance].bikeListJSON bikeList];
    
    serviceOption = [[NSMutableArray alloc] init];
    
    [self.lblDownArrow setFont:[UIFont fontWithName:font_font_awesome_yay size:18]];
    [self.lblDownArrow setText:@"\uf103"];
    
    [self.freeRadio setText:@"\u26AA"];
    [self.paidRadio setText:@"\u26AA"];
    [self.warrantyRadio setText:@"\u26AA"];
    
    [self.freeRadio setUserInteractionEnabled:YES];
    [self.freeText setUserInteractionEnabled:YES];
    [self.paidRadio setUserInteractionEnabled:YES];
    [self.paidText setUserInteractionEnabled:YES];
    [self.warrantyRadio setUserInteractionEnabled:YES];
    [self.warrantyText setUserInteractionEnabled:YES];
    
    [self.freeRadio addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTypeFree)]];
    [self.freeText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTypeFree)]];
    
    [self.paidRadio addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTypePaid)]];
    [self.paidText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTypePaid)]];
    
    [self.warrantyRadio addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTypeWarranty)]];
    [self.warrantyText addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTypeWarranty)]];
    
    self.constrFreeWidth.constant = ([UIScreen mainScreen].bounds.size.width - 40) / 3.0;
    self.constrPaidWidth.constant = self.constrFreeWidth.constant;
    
    self.constrSubmitWidth.constant = [UIScreen mainScreen].bounds.size.width / 2.0;
    
    self.constrPartsChangeWidth.constant = ([UIScreen mainScreen].bounds.size.width - 30) / 2.0;
    self.constrRepairWidth.constant = self.constrPartsChangeWidth.constant;
    
    self.collectionViewParts.delegate = self;
    self.collectionViewParts.dataSource = self;
    self.txtComment.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtComment.layer.borderWidth = 2.0;
    
    [self makeBikeModelList];
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


-(void)makeBikeModelList{
    bikeModelView = [[UIView alloc] initWithFrame:CGRectMake(self.bikeModelButton.frame.origin.x, self.bikeModelButton.frame.origin.y + self.bikeModelButton.frame.size.height + 5, [UIScreen mainScreen].bounds.size.width - 20, 0)];
    
    [bikeModelView setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:.9]];
    
    bikeModelTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, bikeModelView.bounds.size.width, bikeModelView.bounds.size.height)];
    [bikeModelTable setBackgroundColor:[UIColor clearColor]];
    bikeModelTable.delegate = self;
    bikeModelTable.dataSource = self;
    
    [bikeModelView addSubview:bikeModelTable];
    
    [self.view addSubview:bikeModelView];
    [self.view bringSubviewToFront:bikeModelView];
}

-(void)serviceTypeFree{
    [self.freeRadio setText:@"\u26AB"];
    [self.paidRadio setText:@"\u26AA"];
    [self.warrantyRadio setText:@"\u26AA"];
    
    serviceType = @"free";
}
-(void)serviceTypePaid{
    [self.freeRadio setText:@"\u26AA"];
    [self.paidRadio setText:@"\u26AB"];
    [self.warrantyRadio setText:@"\u26AA"];
    
    serviceType = @"paid";
}
-(void)serviceTypeWarranty{
    [self.freeRadio setText:@"\u26AA"];
    [self.paidRadio setText:@"\u26AA"];
    [self.warrantyRadio setText:@"\u26AB"];
    
    serviceType = @"warranty";
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(145, 30);
}


//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfSectionsInCollectionView:(NSInteger)section {
//    //row
//    return 2;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //column
    return [parts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RFSPartsNameCell *cell = nil;
    NSString *CellIdentifier = nil;
    CellIdentifier = @"rfsPartsNameCell";
    cell=(RFSPartsNameCell *) [self.collectionViewParts dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.lblPartsName setText:[parts objectAtIndex:indexPath.row]];
    [cell.lblCheck setText:@"\u2B1C"];//uncheck
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    RFSPartsNameCell *cell =(RFSPartsNameCell*)[collectionView cellForItemAtIndexPath:indexPath];
    //[cell.lblCheck setText:@"\u2705"];//check
    if ([cell.lblCheck.text isEqualToString:@"\u2705"]) {
        [cell.lblCheck setText:@"\u2B1C"];
    } else {
        [cell.lblCheck setText:@"\u2705"];
    }
    if ([serviceOption containsObject:[cell.lblPartsName.text lowercaseString]]) {
        [serviceOption removeObject: [cell.lblPartsName.text lowercaseString]];
    } else {
        [serviceOption addObject:[cell.lblPartsName.text lowercaseString]];
    }
    
    NSLog(@"service option: %@", serviceOption);
}

//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    RFSPartsNameCell *cell =(RFSPartsNameCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    [cell.lblCheck setText:@"\u2B1C"];
//}


- (IBAction)bikeModelAction:(id)sender {
    
    [bikeModelTable reloadData];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         CGRect frame = bikeModelView.frame;
                         frame.size.height = [UIScreen mainScreen].bounds.size.height - bikeModelView.frame.origin.y - 100;//[UIScreen mainScreen].bounds.size.height - (self.bikeModelButton.frame.origin.y + self.bikeModelButton.frame.size.height + 55);
                         bikeModelView.frame = frame;
                         
                         CGRect bFrame = bikeModelTable.frame;
                         bFrame.size.height = bikeModelView.frame.size.height;
                         bikeModelTable.frame = bFrame;
                     }
                     completion:^(BOOL finished){
                         [self.scrollView setUserInteractionEnabled:NO];
                     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bikes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setFont:[UIFont fontWithName:font_suzuki_bold size:18.0]];
    Bike* bike = [bikes objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@ CC", bike.bike_name, bike.bike_cc];
    [cell.textLabel setTextColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return  cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedBikeObject = [bikes objectAtIndex:indexPath.row];
    [self.bikeModelButton setTitle:selectedBikeObject.bike_name forState:UIControlStateNormal];
    //selectedBike = selectedBikeObject.bike_name;
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         CGRect frame = bikeModelView.frame;
                         frame.size.height = 0;//[UIScreen mainScreen].bounds.size.height - (self.bikeModelButton.frame.origin.y + self.bikeModelButton.frame.size.height + 55);
                         bikeModelView.frame = frame;
                         
                         CGRect bFrame = bikeModelTable.frame;
                         bFrame.size.height = 0;
                         bikeModelTable.frame = bFrame;
                     }
                     completion:^(BOOL finished){
                         [self.scrollView setUserInteractionEnabled:YES];
                     }];
    
}
- (IBAction)partsChangeAction:(id)sender {
    
    [self.partsChange setBackgroundColor:[UIColor colorWithRed:33/255.0 green:129/255.0 blue:203/255.0 alpha:1.0]];
    [self.partsChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.repair setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]];
    [self.repair setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    servicingType = @"parts_change";
    
}
- (IBAction)repairAction:(id)sender {
    
    [self.repair setBackgroundColor:[UIColor colorWithRed:33/255.0 green:129/255.0 blue:203/255.0 alpha:1.0]];
    [self.repair setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.partsChange setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]];
    [self.partsChange setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    servicingType = @"repair";
}

-(NSString*)getServiceOptionString{
    
    NSString* str = @"";
    
    for (int i = 0; i < [serviceOption count]; i++) {
        str = [NSString stringWithFormat:@"%@,%@", str, [serviceOption objectAtIndex:i]];
    }
    NSLog(@"str: %@", [str substringFromIndex:1]);
    return [str substringFromIndex:1];
}

- (IBAction)submitAction:(id)sender {
    
    NSDictionary *parameters = @{key_rfs_auth_key: [GlobalInstance sharedInstance].auth_key,
                                 key_rfs_app_user_id:@"418",
                                 key_rfs_bike_id:selectedBikeObject.bike_id,
                                 key_rfs_bike_name:selectedBikeObject.bike_name,
                                 key_rfs_service_type:serviceType,
                                 key_rfs_servicing_type:servicingType,
                                 key_rfs_service_option:[self getServiceOptionString],
                                 key_rfs_cust_comment:self.txtComment.text};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys rfsURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [[GlobalInstance sharedInstance] setRfsJSON:responseObject];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([[GlobalInstance sharedInstance].rfsJSON status]) {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Request Sent."
                                               subtitle:[[GlobalInstance sharedInstance].rfsJSON message]
                                                   type:TSMessageNotificationTypeSuccess];
        } else {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Failed !"
                                               subtitle:[[GlobalInstance sharedInstance].rfsJSON message]
                                                   type:TSMessageNotificationTypeError];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
        
        /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
         message:[error localizedDescription]
         delegate:nil
         cancelButtonTitle:@"Ok"
         otherButtonTitles:nil];
         [alertView show];*/
    }];
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
