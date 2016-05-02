//
//  NSDictionary+Notifications.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 5/1/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+Notifications.h"

@implementation NSDictionary (Notifications)

- (NSNumber *)status_code{
    return @([self[@"status_code"] intValue]);
}
- (NSString *)auth_key{
    return self[@"auth_key"];
}
- (NSString *)message{
    return self[@"message"];
}
- (BOOL)status{
    //    if([self[@"status"] isEqualToString:@"true"]){
    //        return true;
    //    }else{
    //        return false;
    //    }
    return [self[@"status"] boolValue];
    
}

-(NSArray*)getNotifications{
    
    NSArray* notificationArray = self[@"notification"];
    
    NSMutableArray* parsedNotifications = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [notificationArray count]; i++) {
        NSDictionary* tempDict = [notificationArray objectAtIndex:i];
        
        Notification* notification = [[Notification alloc] init];
        
        notification.notification_id = [tempDict valueForKey:@"notification_id"];
        notification.notification_title  = [tempDict valueForKey:@"notification_title"];
        notification.notification_message  = [tempDict valueForKey:@"notification_message"];
        notification.notification_pic = [tempDict valueForKey:@"notification_pic"];
        notification.notification_date  = [tempDict valueForKey:@"notification_date"];
        notification.notification_type  = [tempDict valueForKey:@"notification_type"];

        
        [parsedNotifications addObject:notification];
        
    }
  
    return parsedNotifications;
}
@end


@implementation Notification

@synthesize notification_id, notification_title, notification_message, notification_pic, notification_date, notification_type;

@end