//
//  NewsNdEventViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NewsNdEventListViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "NewsNdEventCell.h"
#import "NSDictionary+NewsNdEvent.h"
#import "NewsNdEventDetailVewController.h"
#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIBarButtonItem+Badge.h"
#import "NotificationListViewController.h"

@implementation NewsNdEventListViewController{
    
    NSArray* allNewsNdEvents;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self getNewsNdEventData];
    
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
-(void) getNewsNdEventData{
    
    NSDictionary *parameters = @{key_news_nd_event_auth_key: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys newsNdEventURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setNewsNdEventJSON:responseObject];
        
        allNewsNdEvents = [[GlobalInstance sharedInstance].newsNdEventJSON getNewsNdEvent];
        NSLog(@"news and event size: %i", [allNewsNdEvents count]); 
        self.newsNdEventTable.delegate = self;
        self.newsNdEventTable.dataSource = self;
        [self.newsNdEventTable reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (![[GlobalInstance sharedInstance].newsNdEventJSON status]) {
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [allNewsNdEvents count]; // in your case, there are 3 cells
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5; // you can have your own choice, of course
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
    
    NewsNdEvent* nNe = [allNewsNdEvents objectAtIndex:indexPath.section];
    
    NSString *CellIdentifier = @"newsNdEventCell";
    NewsNdEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.myImageView setImageWithURL:[NSURL URLWithString:nNe.news_event_img_url]];
    [cell.myTitle setText:nNe.news_event_title];
    [cell.myDescription setText:nNe.news_event_desc];
    
    if ([nNe.type isEqualToString:@"news"]) {
        [cell.newsOrEven setText:@"NEWS"];
    } else {
        [cell.newsOrEven setText:@"EVENT"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    NewsNdEventDetailVewController* nNeD = (NewsNdEventDetailVewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "newsNdEventDetailScene"];
    nNeD.newsNdEventObj = [allNewsNdEvents objectAtIndex:indexPath.section];
    
    [self.navigationController pushViewController:nNeD animated:YES];
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
