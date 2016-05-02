//
//  NSDictionary+Notifications.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 5/1/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property(nonatomic, strong) NSString* notification_id;
@property(nonatomic, strong) NSString* notification_title;
@property(nonatomic, strong) NSString* notification_message;
@property(nonatomic, strong) NSString* notification_pic;
@property(nonatomic, strong) NSString* notification_date;
@property(nonatomic, strong) NSString* notification_type;

@end


@interface NSDictionary (Notifications)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

-(NSArray*)getNotifications;

@end
