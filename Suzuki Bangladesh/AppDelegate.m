//
//  AppDelegate.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 3/21/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "Constant.h"
#import "APIURLsNdKeys.h"
#import "NSDictionary+AuthKey.h"
#import "NSDictionary+MediaURLs.h"
#import "GlobalInstance.h"
#import "HomeViewController.h"
#import "NavigationController.h"
#import "SlideMenuViewController.h"
#import "MBProgressHUD.h"

#import "AFHTTPSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"

#import <objc/runtime.h>

#import "TSMessage.h"
//@import GoogleMaps;

const char MyConstantKey;

@interface AppDelegate ()

@end

@implementation AppDelegate

//UIStoryboard *mainStoryboard;
NSString *emailString = nil;
NSString *tokenString = nil;
NSString *passtring = nil;
BOOL isios8pushON = TRUE;
BOOL isBeforeios8pushON = TRUE;


UIStoryboard *mainStoryboard;
HomeViewController *homeViewController;
NavigationController *navigationController;
SlideMenuViewController *menuController;
REFrostedViewController *frostedViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{UITextAttributeTextColor:[UIColor whiteColor],
       UITextAttributeFont:[UIFont fontWithName:font_suzuki_regular size:18]
       }
                                                                                            forState:UIControlStateNormal];
    [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //[[NSUserDefaults standardUserDefaults] setObject:@"74816a68887abc406c17eb517b6f5bb7" forKey:AUTH_KEY];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:IS_LOGGED_IN] && [[[defaults dictionaryRepresentation] allKeys] containsObject:STRING_USER_ID]){
        
        NSString *is_logged_in = [defaults objectForKey:IS_LOGGED_IN];
        NSString *user_id = [defaults objectForKey:STRING_USER_ID];
        
        if(user_id.length > 0 && user_id != (id)[NSNull null] && user_id != nil){
            [GlobalInstance sharedInstance].isLoggedin = [is_logged_in boolValue];
            [GlobalInstance sharedInstance].user_id = user_id;
        }
        
    }else{
        [GlobalInstance sharedInstance].isLoggedin = false;
        [GlobalInstance sharedInstance].user_id = nil;
    }
    
    if([[[defaults dictionaryRepresentation] allKeys] containsObject:AUTH_KEY]){
        NSLog(@"First IF");
        NSString *auth_key = [defaults objectForKey:AUTH_KEY];
        if(auth_key.length > 0 && auth_key != (id)[NSNull null] && auth_key != nil){
            NSLog(@"Second IF");
            [GlobalInstance sharedInstance].auth_key = auth_key;
            
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            homeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeScene"];
            navigationController = (NavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"contentController"];
            [navigationController setViewControllers:@[homeViewController] animated:YES];
            menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"menuController"];
            
            frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
            frostedViewController.direction = REFrostedViewControllerDirectionLeft;
            
            [self.window.rootViewController.view setBackgroundColor:[UIColor clearColor]];
            
            self.window.rootViewController = frostedViewController;
            
            NSDictionary *parameters = @{key_media_auth_key: [GlobalInstance sharedInstance].auth_key};
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [manager POST:[APIURLsNdKeys mediaURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [[GlobalInstance sharedInstance] setMediaJSON:responseObject];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        }else{
            NSLog(@"First Else");
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            {
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            else
            {
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
                 (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
            }
            
        }
    }else{
        /*NSLog(@"Second Else");
        /*[[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        
        // Let the device know we want to receive push notifications
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            NSLog(@"requesting for notification ");
            UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                            UIUserNotificationTypeBadge |
                                                            UIUserNotificationTypeSound);
            UIUserNotificationType enabledNotifications = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
            if( enabledNotifications == UIUserNotificationTypeNone )
            {
                //NSLog(@"push disable for ios8");
                isios8pushON = FALSE;
                NSString *is_push_enable = @"0";
                [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
            }
            else
            {
                //NSLog(@"push enable for ios8");
                isios8pushON = TRUE;
                NSString *is_push_enable = @"1";
                [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
            }
            
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                     categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
            
        } else {
            // Register for Push Notifications before iOS 8
            [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                             UIRemoteNotificationTypeAlert |
                                                             UIRemoteNotificationTypeSound)];
            UIRemoteNotificationType enabledNotifications = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
            if( enabledNotifications == UIRemoteNotificationTypeNone )
            {
                //NSLog(@"push disable for before ios8");
                isBeforeios8pushON = FALSE;
                NSString *is_push_enable = @"0";
                [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
            }
            else
            {
                //NSLog(@"push enable for before ios8");
                isBeforeios8pushON = TRUE;
                NSString *is_push_enable = @"1";
                [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
            }
        }*/
        
        NSLog(@"Second Else");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        }
        
    }
    
    
    /* vai's code
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    
    // Let the device know we want to receive push notifications
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        NSLog(@"requesting for notification ");
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationType enabledNotifications = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
        if( enabledNotifications == UIUserNotificationTypeNone )
        {
            //NSLog(@"push disable for ios8");
            isios8pushON = FALSE;
            NSString *is_push_enable = @"0";
            [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
        }
        else
        {
            //NSLog(@"push enable for ios8");
            isios8pushON = TRUE;
            NSString *is_push_enable = @"1";
            [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
        }
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
        
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
        UIRemoteNotificationType enabledNotifications = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if( enabledNotifications == UIRemoteNotificationTypeNone )
        {
            //NSLog(@"push disable for before ios8");
            isBeforeios8pushON = FALSE;
            NSString *is_push_enable = @"0";
            [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
        }
        else
        {
            //NSLog(@"push enable for before ios8");
            isBeforeios8pushON = TRUE;
            NSString *is_push_enable = @"1";
            [[NSUserDefaults standardUserDefaults] setObject:is_push_enable forKey:IS_PUSH_ENABLE];
        }
    }
    
    // Override point for customization after application launch.
    mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:@"firsttime"] == nil) {
        [defaults setValue:@"true" forKey:@"firsttime"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:APP_TOKEN];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
    tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:APP_TOKEN];
    
    NSString *dtoken = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_TOKEN];
    if(dtoken.length > 0 && dtoken != (id)[NSNull null])
    {
        NSLog(@"the token from sharedDefaults: %@", dtoken);
    }
    else{
        NSLog(@"running for first time");
    }
    NSString *is_push_enable = [[NSUserDefaults standardUserDefaults] objectForKey:IS_PUSH_ENABLE];
    */
    /*
    NSString *dtoken = [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_TOKEN];
    NSLog(@"device token from shared defaults: %@", dtoken);
   
    NSDictionary *parameters = @{key_getAuthKey_unique_device_id: dtoken,
                                 key_getAuthKey_notification_key: dtoken,
                                 key_getAuthKey_platform: @"2"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    __block NSDictionary *authkey;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HomeViewController *homeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeScene"];
    NavigationController *navigationController = (NavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"contentController"];
    [navigationController setViewControllers:@[homeViewController] animated:YES];
    SlideMenuViewController *menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"menuController"];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    
    [self.window.rootViewController.view setBackgroundColor:[UIColor clearColor]];
    [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
    
    [manager POST:[APIURLsNdKeys getAuthKeyURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        authkey = responseObject;
        NSLog(@"Dictionary Check: %@", [authkey message]);
        [[GlobalInstance sharedInstance] setAuthKeyJSON:authkey];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[GlobalInstance sharedInstance].authKeyJSON auth_key] forKey:AUTH_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [MBProgressHUD hideHUDForView:self.window.rootViewController.view animated:YES];
        self.window.rootViewController = frostedViewController;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.window.rootViewController.view animated:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];*/
    
    
    
//    NSDictionary *parameters = @{key_media_auth_key: [GlobalInstance sharedInstance].auth_key};
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [manager POST:[APIURLsNdKeys mediaURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        [[GlobalInstance sharedInstance] setMediaJSON:responseObject];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//    }];
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // NS_AVAILABLE_IOS(8_0);
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSLog(@"deviceToken: %@", deviceToken);
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:DEVICE_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"token new way: %@", token);
    
    [self getTheAuthKey:token];
    
    
    
    
    
    /*vai's code
    NSLog(@"request received ");
    NSLog(@"FROM DEVICE token is: %@", deviceToken);
    
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:DEVICE_TOKEN]; //save token to resend it if request fails
    NSLog(@"My device token is : %@",token);
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"apnsTokenSentSuccessfully"]; // set flag for request status
    
    
    [self getAuthKey:token];
     */
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    //NSLog(@"Failed to get token, error: %@", error);
    
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    NSLog(@"Received notification: %@", userInfo);
    
    NSString *item_type = [[userInfo valueForKey:@"aps"] valueForKey:@"item_type"];
    NSLog(@"get item_type :%@",item_type);
    
    NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
        NSString *cancelTitle = @"Close";
        NSString *showTitle = @"Show";
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Push Notification"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:showTitle, nil];
        [alertView show];
        objc_setAssociatedObject(alertView, &MyConstantKey, item_type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //[alertView release];
    }
    else
    {
        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:APP_TOKEN];
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:STRING_USER_ID];
        
        if( [user_id intValue] != 0 || [token length] != 0)
        {
            //Do stuff that you would do if the application was not active
            
        }
        
    }
    //[self addMessageFromRemoteNotification:userInfo updateUI:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        
        NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:APP_TOKEN];
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:STRING_USER_ID];
        if( [user_id intValue] != 0 || [token length] != 0)
        {
            NSString *associatedString = objc_getAssociatedObject(alertView, &MyConstantKey);
            //NSLog(@"associated string: %@", associatedString);
            //NSLog(@"Launching the store");
            
            if( [associatedString isEqualToString:@"stream"] )
            {
                
            }else if( [associatedString isEqualToString:@"coupon"] )
            {
                
            }
            else if( [associatedString isEqualToString:@"benefit"] )
            {
                
            }
        }
        else
        {
            //NSLog(@"userid and token not found");
        }
        
    }
}
/*
-(void)getAuthKey:(NSString*)token{
 
    NSDictionary *parameters = @{key_getAuthKey_unique_device_id: token,
                                 key_getAuthKey_notification_key: token,
                                 key_getAuthKey_platform: @"2"};

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    __block NSDictionary *authkey;
    
    UIActivityIndicatorView *loading = [[GlobalInstance sharedInstance] activityView];
    loading.center = self.window.rootViewController.view.center;
    [self.window.rootViewController.view addSubview:loading];
    [loading startAnimating];
    
    [manager POST:[APIURLsNdKeys getAuthKeyURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
       authkey = responseObject;
        NSLog(@"Dictionary Check: %@", [authkey message]);
        [[GlobalInstance sharedInstance] setAuthKeyJSON:authkey];
        
        HomeViewController *homeViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"homeScene"];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
        self.window.rootViewController = navController;
        
        [loading stopAnimating];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [loading stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [loading removeFromSuperview];
}*/


-(void) getTheAuthKey:(NSString*)token{
    NSLog(@"get auth key from delegate");
    NSDictionary *parameters = @{key_getAuthKey_unique_device_id: token,
                                 key_getAuthKey_notification_key: token,
                                 key_getAuthKey_platform: @"2"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    __block NSDictionary *authkey;
    
    mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    homeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeScene"];
    navigationController = (NavigationController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"contentController"];
    [navigationController setViewControllers:@[homeViewController] animated:YES];
    menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"menuController"];
    
    frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    
    [self.window.rootViewController.view setBackgroundColor:[UIColor clearColor]];
    [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
    
    [manager POST:[APIURLsNdKeys getAuthKeyURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        authkey = responseObject;
        NSLog(@"Dictionary Check: %@", [authkey message]);
        [[GlobalInstance sharedInstance] setAuthKeyJSON:authkey];
        if ([[GlobalInstance sharedInstance].authKeyJSON status]) {
            [[NSUserDefaults standardUserDefaults] setObject:[[GlobalInstance sharedInstance].authKeyJSON auth_key] forKey:AUTH_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSDictionary *parameters = @{key_media_auth_key: [GlobalInstance sharedInstance].auth_key};
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [manager POST:[APIURLsNdKeys mediaURL] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [[GlobalInstance sharedInstance] setMediaJSON:responseObject];
                
                self.window.rootViewController = frostedViewController;
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        } else {
            [MBProgressHUD hideHUDForView:self.window.rootViewController.view animated:YES];
            
            [TSMessage showNotificationWithTitle:@"Error Retrieving Data"
                                        subtitle:[[GlobalInstance sharedInstance].authKeyJSON message]
                                            type:TSMessageNotificationTypeError];
            
            /*[[[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                        message:[[GlobalInstance sharedInstance].authKeyJSON message]
                                      delegate:nil
                             cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];*/
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.window.rootViewController.view animated:YES];
        
        
        [TSMessage showNotificationWithTitle:@"Error Retrieving Data"
                                    subtitle:[error localizedDescription]
                                        type:TSMessageNotificationTypeError];
        
       /* UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];*/
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

