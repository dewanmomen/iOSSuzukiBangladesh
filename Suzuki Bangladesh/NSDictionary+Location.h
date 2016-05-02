//
//  NSDictionary+Location.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property(nonatomic, strong) NSString* location_id;
@property(nonatomic, strong) NSString* location_type;
@property(nonatomic, strong) NSString* location_name;
@property(nonatomic, strong) NSString* location_address;
@property(nonatomic, strong) NSString* location_contact_person_name;
@property(nonatomic, strong) NSString* location_contact_person_email;
@property(nonatomic, strong) NSString* location_contact_person_phone;
@property(nonatomic, strong) NSString* latitude;
@property(nonatomic, strong) NSString* longitude;
@end


@interface NSDictionary (Location)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;


-(NSArray*)getLocations;

@end
