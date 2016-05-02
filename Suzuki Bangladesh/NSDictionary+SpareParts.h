//
//  NSDictionary+SpareParts.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpareParts : NSObject

@property(nonatomic, strong) NSString* spare_parts_id;
@property(nonatomic, strong) NSString* spare_parts_name;
@property(nonatomic, strong) NSString* spare_parts_price;
@property(nonatomic, strong) NSString* spare_parts_code;
@property(nonatomic, strong) NSString* parts_type;
@property(nonatomic, strong) NSString* thumble_img;
@property(nonatomic, strong) NSString* status;

@end


@interface CartItem : NSObject

@property(nonatomic, strong) SpareParts* spareObj;
@property(nonatomic, assign) int quantity;

@end

@interface NSDictionary (SpareParts)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(NSArray*)getSpareParts;
@end
