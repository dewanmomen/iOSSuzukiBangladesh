//
//  NSDictionary+BikeList.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/11/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BikeList)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(NSArray*)bikeList;

@end


@interface Bike : NSObject

@property(nonatomic, strong) NSString* bike_code;
@property(nonatomic, strong) NSString* bike_id;
@property(nonatomic, strong) NSString* bike_name;
@property(nonatomic, strong) NSString* thumble_img;

@property(nonatomic, strong) NSString* bike_cc;
@property(nonatomic, strong) NSString* bike_mileage;
@end