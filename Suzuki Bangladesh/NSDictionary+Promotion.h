//
//  NSDictionary+Promotion.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Promotion : NSObject

@property(nonatomic, strong) NSString* promo_id;
@property(nonatomic, strong) NSString* promo_title;
@property(nonatomic, strong) NSString* promo_desc;
@property(nonatomic, strong) NSString* promo_image;
@property(nonatomic, strong) NSString* start_date;
@property(nonatomic, strong) NSString* end_date;

@end

@interface NSDictionary (Promotion)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(NSArray*)getPromotions;

@end
