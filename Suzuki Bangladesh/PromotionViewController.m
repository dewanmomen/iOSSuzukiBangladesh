//
//  PromotionViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "PromotionViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "NewsNdEventCell.h"
#import "NSDictionary+Promotion.h"
#import "NewsNdEventDetailVewController.h"
#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIBarButtonItem+Badge.h"

#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

@implementation PromotionViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.constrDetailImageHeight.constant = ([UIScreen mainScreen].bounds.size.height * 60)/100;//[UIScreen mainScreen].bounds.size.width / .568;
    
    [self getPromotion];
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


-(void) getPromotion{
    
    NSDictionary *parameters = @{key_promotion_auth_key: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys promotionURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setPromotionJSON:responseObject];
    
        Promotion* promo = [((NSArray*)[[GlobalInstance sharedInstance].promotionJSON getPromotions]) objectAtIndex:0];
        
        [self.promotionImage setImageWithURL:[NSURL URLWithString:promo.promo_image]];
        [self.detailTitle setText:promo.promo_title];
        [self.detailsDesc setText:promo.promo_desc];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (![[GlobalInstance sharedInstance].promotionJSON status]) {
            [TSMessage showNotificationInViewController:self
                                                  title:@"Failed to load Data !"
                                               subtitle:[[GlobalInstance sharedInstance].newsNdEventJSON message]
                                                   type:TSMessageNotificationTypeError];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [TSMessage showNotificationInViewController:self
                                              title:@"Error Retrieving Data"
                                           subtitle:[error localizedDescription]
                                               type:TSMessageNotificationTypeError];
        
        
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
