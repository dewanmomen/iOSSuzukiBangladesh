//
//  NSDictionary+Promotion.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+Promotion.h"


@implementation Promotion

@synthesize promo_id, promo_title, promo_desc, promo_image, start_date, end_date;

@end


@implementation NSDictionary (Promotion)

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

-(NSArray*)getPromotions{
    
    NSArray* promotionArray = self[@"promotion"];
    
    NSMutableArray* parsedPromotionArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [promotionArray count]; i++) {
        
        NSDictionary* tempDict = [promotionArray objectAtIndex:i];
        
        Promotion* prom = [[Promotion alloc] init];
        
        prom.promo_id = [tempDict valueForKey:@"promo_id"];
        prom.promo_title = [tempDict valueForKey:@"promo_title"];
        prom.promo_desc = [tempDict valueForKey:@"promo_desc"];
        prom.promo_image = [tempDict valueForKey:@"promo_image"];
        prom.start_date = [tempDict valueForKey:@"start_date"];
        prom.end_date = [tempDict valueForKey:@"end_date"];
        
        [parsedPromotionArray addObject:prom];
        
    }
    
    return parsedPromotionArray;
}
@end
