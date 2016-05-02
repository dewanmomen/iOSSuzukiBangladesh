//
//  MyCartViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/29/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "MyCartViewController.h"


#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "CartItemCell.h"
#import "CartTotalCell.h"
#import "NSDictionary+SpareParts.h"

#import "NavigationController.h"
#import "SparePartsListViewController.h"

#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"

#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

@implementation MyCartViewController{
    
    NSMutableArray* cartItems;
    BOOL isRemovingRow;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.constrSpareTabWidth.constant = ([UIScreen mainScreen].bounds.size.width - 20) / 2.0;
    [self.lblspareIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
    [self.lblspareIcon setText:@"\uf013"];
    [self.lblCartIcon setFont:[UIFont fontWithName:font_font_awesome_yay size:18.0]];
    [self.lblCartIcon setText:@"\uf07a"];
    
    float mainWidth = [UIScreen mainScreen].bounds.size.width - 20;
    self.constrQtyWidth.constant = mainWidth / 10.0;
    self.constrItemWidth.constant = self.constrQtyWidth.constant * 05;
    
    isRemovingRow = NO;
    
    cartItems = [GlobalInstance sharedInstance].itemsInCart;
    
    self.cartTable.delegate = self;
    self.cartTable.dataSource = self;
    [self.cartTable reloadData];
    
    
    [self.spareUIView setUserInteractionEnabled:YES];
    [self.spareUIView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCart)]];
    
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
    
    SparePartsListViewController *spareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"spareListScene"];
    
    navigationController.viewControllers = @[spareViewController];
    
    self.frostedViewController.contentViewController = navigationController;
    
}
-(void)setUpTheConstr{
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cartItems count] > 0) {
        if (indexPath.row == [cartItems count]) {
            return 30;
        } else {
            return 50;
        }
    } else {
        return 30;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rows;
    if ([cartItems count] > 0) {
        rows = [cartItems count] + 1;
    } else {
        rows = 1;
    }
    
    if (isRemovingRow) {
        rows --;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cartItems count] > 0) {
    
        if (indexPath.row == [cartItems count]) {
            
            static NSString *CellIdentifier = @"cartTotalCell";
            CartTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //float mainWidth = [UIScreen mainScreen].bounds.size.width - 20;
            //cell.constrTotalFirstLeading.constant = ((mainWidth / 10.0) * 6.0) + 1;
            cell.constrTotalFirstLeading.constant = self.constrQtyWidth.constant + self.constrItemWidth.constant + 1;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            float totalPrice = 0;
            
            for (int i = 0; i < [cartItems count]; i++) {
                CartItem* ci = [cartItems objectAtIndex:i];
                SpareParts* sp = ci.spareObj;
                
                totalPrice += ci.quantity * [sp.spare_parts_price floatValue];
            }
            
            [cell.lblTotalPrice setText:[NSString stringWithFormat:@"%.02f tk", totalPrice]];
            
            return  cell;
            
        } else {
            
            static NSString *CellIdentifier = @"cartItemCell";
            CartItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            CartItem* ci = [cartItems objectAtIndex:indexPath.row];
            
            float mainWidth = [UIScreen mainScreen].bounds.size.width - 20;
            cell.constrItemCellFirstLeading.constant = mainWidth / 10.0;
            cell.constrItemCellSecondLeading.constant = cell.constrItemCellFirstLeading.constant * 5.0;
            
            [cell.lblQty setText:[NSString stringWithFormat:@"%02i", ci.quantity]];
            SpareParts* sp = ci.spareObj;
            [cell.lblPartsName setText:sp.spare_parts_name];
            [cell.lblPrice setText:[NSString stringWithFormat:@"%.02f tk", ci.quantity * [sp.spare_parts_price floatValue]]];
            
            [cell.imgCancel setTag:indexPath.row];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeItem:)];
            [tap setNumberOfTapsRequired:1];
            [cell.imgCancel setUserInteractionEnabled:YES];
            [cell.imgCancel addGestureRecognizer:tap];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;
            
        }
        
    }else{
        
        static NSString *CellIdentifier = @"newFriendCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        [cell.textLabel setFont:[UIFont fontWithName:font_suzuki_regular size:14.0]];
        cell.textLabel.text = @"No Item in Cart";
        [cell.textLabel setTextColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return  cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)removeItem:(UITapGestureRecognizer*)sender{
    
    NSLog(@"%d", ((UIImageView*)sender.view).tag);
    
    int tag = ((UIImageView*)sender.view).tag;
    
    NSArray *indexPaths = @[[NSIndexPath indexPathForRow:tag inSection:0]];
    
    isRemovingRow = YES;
    [self.cartTable deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    isRemovingRow = NO;
    
    [cartItems removeObjectAtIndex:tag];
    [[GlobalInstance sharedInstance] setItemsInCart:cartItems];
    
    [self.cartTable reloadData];
    
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
