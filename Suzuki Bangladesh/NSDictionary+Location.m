//
//  NSDictionary+Location.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+Location.h"

@implementation Location

@synthesize location_id, location_type, location_name, location_address, location_contact_person_name, location_contact_person_email, location_contact_person_phone, latitude, longitude;

@end


@implementation NSDictionary (Location)


- (NSNumber *)status_code{
    return @([self[@"status_code"] intValue]);
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


-(NSArray*)getLocations{
    
    NSArray* locationArray = self[@"location"];
    
    NSMutableArray* parsedLocationArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [locationArray count]; i++) {
        NSDictionary* tempDict = [locationArray objectAtIndex:i];
        
        Location* loc = [[Location alloc] init];
        loc.location_id = [tempDict valueForKey:@"location_id"];
        loc.location_type = [tempDict valueForKey:@"location_type"];
        loc.location_name = [tempDict valueForKey:@"location_name"];
        loc.location_address = [tempDict valueForKey:@"location_address"];
        loc.location_contact_person_name = [tempDict valueForKey:@"location_contact_person_name"];
        loc.location_contact_person_email = [tempDict valueForKey:@"location_contact_person_email"];
        loc.location_contact_person_phone = [tempDict valueForKey:@"location_contact_person_phone"];
        loc.latitude = [tempDict valueForKey:@"latitude"];
        loc.longitude = [tempDict valueForKey:@"longitude"];
        
        [parsedLocationArray addObject:loc];
    }
    
    return parsedLocationArray;
}

@end
