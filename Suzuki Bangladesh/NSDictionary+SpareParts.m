//
//  NSDictionary+SpareParts.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+SpareParts.h"


@implementation SpareParts

@synthesize spare_parts_id, spare_parts_name, spare_parts_price, spare_parts_code, parts_type, thumble_img, status;

@end

@implementation CartItem

@synthesize spareObj, quantity;

@end


@implementation NSDictionary (SpareParts)

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


-(NSArray*)getSpareParts{
    
    NSArray* spareArray = self[@"spare"];
    
    NSMutableArray* parsedSpareArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< [spareArray count]; i++) {
        NSDictionary* tempDict = [spareArray objectAtIndex:i];
        
        SpareParts* sp = [[SpareParts alloc] init];
        sp.spare_parts_id = [tempDict valueForKey:@"spare_parts_id"];
        sp.spare_parts_name = [tempDict valueForKey:@"spare_parts_name"];
        sp.spare_parts_price = [tempDict valueForKey:@"spare_parts_price"];
        sp.spare_parts_code = [tempDict valueForKey:@"spare_parts_code"];
        sp.parts_type = [tempDict valueForKey:@"parts_type"];
        sp.thumble_img = [tempDict valueForKey:@"thumble_img"];
        sp.status = [tempDict valueForKey:@"status"];
        
        NSLog(@"parts price from parser: %@", sp.spare_parts_price);
        [parsedSpareArray addObject:sp];
    }
    
    return parsedSpareArray;
}
@end
