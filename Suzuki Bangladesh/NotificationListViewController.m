//
//  NotificationListViewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NotificationListViewController.h"

#import "GlobalInstance.h"
#import "APIURLsNdKeys.h"
#import "NotificationCell.h"
#import "NSDictionary+Notifications.h"
#import "NewsNdEventDetailVewController.h"
#import "MBProgressHUD.h"
#import "TSMessage.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIBarButtonItem+Badge.h"

@implementation NotificationListViewController{
    NSArray* allNotifications;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"Notifications";
    
    [self getNotifications];
}


-(void) getNotifications{
    
    NSDictionary *parameters = @{key_notification_auth_key: [GlobalInstance sharedInstance].auth_key};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [manager POST:[APIURLsNdKeys notificationsListURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [[GlobalInstance sharedInstance] setNotificationsListJSON:responseObject];
        
        allNotifications = [[GlobalInstance sharedInstance].notificationsListJSON getNotifications];
        
        self.notificationTable.delegate = self;
        self.notificationTable.dataSource = self;
        [self.notificationTable reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (![[GlobalInstance sharedInstance].notificationsListJSON status]) {
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
    if([allNotifications count] > 0)
    return 120;
    else return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([allNotifications count] > 0)
    return [allNotifications count];
    else return 1;
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
    if ([allNotifications count] > 0) {
        Notification* notification = [allNotifications objectAtIndex:indexPath.section];
        
        NSString *CellIdentifier = @"notificationCell";
        NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        [cell.myImage setImageWithURL:[NSURL URLWithString:notification.notification_pic]];
        [cell.myTitle setText:notification.notification_title];
        [cell.myDesctiption setText:notification.notification_message];
        
        if ([notification.notification_type isEqualToString:@"promotions"]) {
            [cell.notificationType setText:@" PROMOTION "];
        } else if ([notification.notification_type isEqualToString:@"request_for_service"]){
            [cell.notificationType setText:@" SERVICE "];
        }
        else if ([notification.notification_type isEqualToString:@"quiz_publish"]){
            [cell.notificationType setText:@" NEW QUIZ "];
        }
        else if ([notification.notification_type isEqualToString:@"quiz_result"]){
            [cell.notificationType setText:@" QUIZ RESULT "];
        }
        else if ([notification.notification_type isEqualToString:@"news_events"]){
            [cell.notificationType setText:@" NEWS & EVENT "];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"newFriendCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        [cell.textLabel setFont:[UIFont fontWithName:font_suzuki_regular size:18.0]];
        cell.textLabel.text = @"No New Notifications";
        [cell.textLabel setTextColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return  cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
//    NewsNdEventDetailVewController* nNeD = (NewsNdEventDetailVewController *)[self.storyboard instantiateViewControllerWithIdentifier:@ "newsNdEventDetailScene"];
//    nNeD.newsNdEventObj = [allNewsNdEvents objectAtIndex:indexPath.section];
//    
//    [self.navigationController pushViewController:nNeD animated:YES];
}

@end
