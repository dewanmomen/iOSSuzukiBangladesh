//
//  NSDictionary+BikeList.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/11/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+BikeList.h"

@implementation NSDictionary (BikeList)

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

-(NSArray*)bikeList{
    NSArray* bikes = self[@"bikeList"];
    NSMutableDictionary* parsedDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray* allBikesArray = [[NSMutableArray alloc] init];
    Bike* bikeObject = [[Bike alloc] init];
    for (int i = 0; i < [bikes count]; i++) {
        parsedDictionary = [bikes objectAtIndex:i];
        bikeObject.bike_code = [parsedDictionary valueForKey:@"bike_code"];
        bikeObject.bike_id = [parsedDictionary valueForKey:@"bike_id"];
        bikeObject.bike_name = [parsedDictionary valueForKey:@"bike_name"];
        bikeObject.thumble_img = [parsedDictionary valueForKey:@"thumble_img"];
        bikeObject.bike_cc = [parsedDictionary valueForKey:@"bike_cc"];
        bikeObject.bike_mileage = [parsedDictionary valueForKey:@"bike_mileage"];
        
        [allBikesArray addObject:bikeObject];
        bikeObject = [[Bike alloc] init];
    }
    return allBikesArray;
}

@end


@implementation Bike

@synthesize bike_id, bike_name, bike_code, thumble_img, bike_cc, bike_mileage;

@end