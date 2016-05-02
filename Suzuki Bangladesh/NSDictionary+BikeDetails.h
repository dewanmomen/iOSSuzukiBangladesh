//
//  NSDictionary+BikeDetails.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/12/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BikeBasic : NSObject

@property(nonatomic, strong) NSString* bike_code;
@property(nonatomic, strong) NSString* bike_id;
@property(nonatomic, strong) NSString* bike_name;
@property(nonatomic, strong) NSString* bike_cc;
@property(nonatomic, strong) NSString* bike_mileage;
@property(nonatomic, strong) NSString* thumble_img;

@end


@interface BikeSpecification : NSObject

@property(nonatomic, strong) NSString* specification_category;
@property(nonatomic, strong) NSString* specification_title;
@property(nonatomic, strong) NSString* specification_value;

@end

@interface BikeImage : NSObject

@property(nonatomic, strong) NSString* large_image_link;
@property(nonatomic, strong) NSString* image_color;

@end

@interface Engine : NSObject

@property(nonatomic, strong) NSString* category_name;
@property(nonatomic, strong) NSMutableArray* specs;

@end

@interface Electrical : NSObject

@property(nonatomic, strong) NSString* category_name;
@property(nonatomic, strong) NSMutableArray* specs;

@end

@interface Suspension : NSObject

@property(nonatomic, strong) NSString* category_name;
@property(nonatomic, strong) NSMutableArray* specs;

@end

@interface Tyre : NSObject

@property(nonatomic, strong) NSString* category_name;
@property(nonatomic, strong) NSMutableArray* specs;

@end

@interface Brake : NSObject

@property(nonatomic, strong) NSString* category_name;
@property(nonatomic, strong) NSMutableArray* specs;

@end

@interface Dimensions : NSObject

@property(nonatomic, strong) NSString* category_name;
@property(nonatomic, strong) NSMutableArray* specs;

@end

@interface SingleBikeDetails : NSObject

@property(nonatomic, strong) BikeBasic* basic;
@property(nonatomic, strong) NSMutableArray* specs;
@property(nonatomic, strong) NSMutableArray* images;

@property(nonatomic, strong) Engine* engine;
@property(nonatomic, strong) Electrical* electrical;
@property(nonatomic, strong) Suspension* suspension;
@property(nonatomic, strong) Tyre* tyre;
@property(nonatomic, strong) Brake* brake;
@property(nonatomic, strong) Dimensions* dimensions;

-(NSInteger) rows;

@end

@interface NSDictionary (BikeDetails)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(SingleBikeDetails*) bikeDetails;

@end
