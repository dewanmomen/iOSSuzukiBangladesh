//
//  SpartPartsList.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "SparePartsListViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "SparePartsCell.h"
#import "NSDictionary+SpareParts.h"

#import "NavigationController.h"
#import "MyCartViewController.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import "UIImageView+AFNetworking.h"
#import <AFNetworking+ImageActivityIndicator/AFNetworking+ImageActivityIndicator.h>

#import <QuartzCore/QuartzCore.h>

#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"


@implementation SparePartsListViewController{
    
    NSArray* allParts;
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.constrSpareTabWidth.constant = ([UIScreen mainScreen].bounds.size.width - 20) / 2.0;
    [self.lblspareIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
    [self.lblspareIcon setText:@"\uf013"];
    [self.lblCartIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
    [self.lblCartIcon setText:@"\uf07a"];
    [self.lblSearchIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
    [self.lblSearchIcon setText:@"\uf002"];
    
    [self.cartUIView setUserInteractionEnabled:YES];
    [self.cartUIView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCart)]];
    //self.spareTable.allowsSelection = NO;
    [self getSpareData];
    
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
-(void)loadCart{
    
    NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    MyCartViewController *myCartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"myCartScene"];
    
    navigationController.viewControllers = @[myCartViewController];
    
    self.frostedViewController.contentViewController = navigationController;
    
}

-(void) getSpareData{
    
    NSDictionary *parameters = @{key_spare_list_auth_key: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys spareListURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [[GlobalInstance sharedInstance] setSpareJSON:responseObject];
        
        allParts = [[GlobalInstance sharedInstance].spareJSON getSpareParts];
        
        self.spareTable.delegate = self;
        self.spareTable.dataSource = self;
        [self.spareTable reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
    }];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([allParts count] > 0) return 200;
    else return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([allParts count] > 0) return [allParts count];
    else return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.;
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
    if ([allParts count] > 0) {
        float mainWidth = [[UIScreen mainScreen]bounds].size.width - 20;
        SpareParts* spareP = [allParts objectAtIndex:indexPath.section];
        
        NSString *CellIdentifier = @"spareCell";
        SparePartsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.constrPartsNameViewWidth.constant = mainWidth / 2.0;
        cell.constrFirstVerticalViewLeading.constant = mainWidth / 2.0;
        cell.costrBikeNameWidth.constant = cell.constrFirstVerticalViewLeading.constant;
        cell.constrSecondVerticalViewLeading.constant = cell.constrFirstVerticalViewLeading.constant / 1.5;
        
        [cell.lblPartsName setText:spareP.spare_parts_name];
        [cell.lblPartsPrice setText:[NSString stringWithFormat:@"%@ tk", spareP.spare_parts_price]];
        
        [cell.lblCartIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
        [cell.lblCartIcon setText:@"\uf217"];
        [cell.lblCartIcon setTag:indexPath.section];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addToCart:)];
        [tap setNumberOfTapsRequired:1];
        [cell.lblCartIcon setUserInteractionEnabled:YES];
        [cell.lblCartIcon addGestureRecognizer:tap];
        
        [cell.imgPartsImage setClipsToBounds:YES];
        [cell.imgPartsImage setImageWithURL:[NSURL URLWithString:spareP.thumble_img] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.borderColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0].CGColor;
        cell.layer.borderWidth = 1.0;
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"newFriendCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        [cell.textLabel setFont:[UIFont fontWithName:font_suzuki_regular size:18.0]];
        cell.textLabel.text = [[GlobalInstance sharedInstance].spareJSON message];
        [cell.textLabel setTextColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return  cell;
    }
    
}


-(void)addToCart:(UITapGestureRecognizer*)sender{
    
    //NSLog(@"%d", ((UILabel*)sender.view).tag);
    
    int tag = ((UILabel*)sender.view).tag;
    
    BOOL isIt = YES;
    
    SpareParts* sp = [allParts objectAtIndex:tag];
    
    NSMutableArray* cartItemsArray = [[NSMutableArray alloc] initWithArray:[GlobalInstance sharedInstance].itemsInCart];
    
    for (int i = 0; i < [[GlobalInstance sharedInstance].itemsInCart count]; i++) {
        CartItem* tempCI = [[GlobalInstance sharedInstance].itemsInCart objectAtIndex:i];
        SpareParts* tempSP = tempCI.spareObj;
        if ([tempSP.spare_parts_id isEqualToString:sp.spare_parts_id]) {
            tempCI.quantity = tempCI.quantity + 1;
            [cartItemsArray removeObjectAtIndex:i];
            [cartItemsArray addObject:tempCI];
            isIt = NO;
        }
    }
    
    if(isIt){
        CartItem* ci = [[CartItem alloc] init];
        [ci setSpareObj:sp];
        [ci setQuantity:1];
        [cartItemsArray addObject:ci];
    }
    
    [[GlobalInstance sharedInstance] setItemsInCart:cartItemsArray];
    
    int i = 2;
    NSTimeInterval interval = i;
    
    [TSMessage showNotificationInViewController:self
                                          title:sp.spare_parts_name
                                       subtitle:@"Added To Cart"
                                           type:TSMessageNotificationTypeMessage
                                       duration:interval
                           canBeDismissedByUser:YES];
    
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
