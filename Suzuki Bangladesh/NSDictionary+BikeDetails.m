//
//  NSDictionary+BikeDetails.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/12/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+BikeDetails.h"

@implementation NSDictionary (BikeDetails)

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

-(SingleBikeDetails*) bikeDetails{
    NSDictionary* detailsDictionary = self[@"bikeDetails"];
    
    NSArray* basicArray = detailsDictionary[@"basic"];
    NSDictionary* basicDict = [basicArray objectAtIndex:0];
    BikeBasic* bb = [[BikeBasic alloc] init];
    bb.bike_id = [basicDict valueForKey:@"bike_id"];
    bb.bike_code = [basicDict valueForKey:@"bike_code"];
    bb.bike_name = [basicDict valueForKey:@"bike_name"];
    bb.thumble_img = [basicDict valueForKey:@"thumble_img"];
    bb.bike_cc = [basicDict valueForKey:@"bike_cc"];
    bb.bike_mileage = [basicDict valueForKey:@"bike_mileage"];
    
    
    NSDictionary* specDictionary = detailsDictionary[@"specification"];
    
    NSArray* engineArray = specDictionary[@"Engine"];
    NSMutableArray* parsedEngineArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [engineArray count]; i++) {
        NSDictionary* dict = [engineArray objectAtIndex:i];
        BikeSpecification* specObj = [[BikeSpecification alloc] init];
        specObj.specification_category = @"Engine";
        specObj.specification_title = [dict valueForKey:@"specification_title"];
        specObj.specification_value = [dict valueForKey:@"specification_value"];
        [parsedEngineArray addObject:specObj];
        specObj = nil;
    }
    Engine* engine = [[Engine alloc] init];
    engine.category_name = @"Engine";
    engine.specs = [[NSMutableArray alloc] initWithArray:parsedEngineArray];
    
    NSArray* electricalArray = specDictionary[@"Electrical"];
    NSMutableArray* parsedElectricalArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [electricalArray count]; i++) {
        NSDictionary* dict = [electricalArray objectAtIndex:i];
        BikeSpecification* specObj = [[BikeSpecification alloc] init];
        specObj.specification_category = @"Electrical";
        specObj.specification_title = [dict valueForKey:@"specification_title"];
        specObj.specification_value = [dict valueForKey:@"specification_value"];
        [parsedElectricalArray addObject:specObj];
        specObj = nil;
    }
    Electrical* electrical = [[Electrical alloc] init];
    electrical.category_name = @"Electrical";
    electrical.specs = [[NSMutableArray alloc] initWithArray:parsedElectricalArray];
    
    NSArray* suspentionArray = specDictionary[@"Suspension"];
    NSMutableArray* parsedsuspentionArray = [[NSMutableArray  alloc] init];
    for (int i = 0; i < [suspentionArray count]; i++) {
        NSDictionary* dict = [suspentionArray objectAtIndex:i];
        BikeSpecification* specObj = [[BikeSpecification alloc] init];
        specObj.specification_category = @"Suspension";
        specObj.specification_title = [dict valueForKey:@"specification_title"];
        specObj.specification_value = [dict valueForKey:@"specification_value"];
        [parsedsuspentionArray addObject:specObj];
        specObj = nil;
    }
    Suspension* suspension = [[Suspension alloc] init];
    suspension.category_name = @"Suspension";
    suspension.specs = [[NSMutableArray alloc] initWithArray:parsedsuspentionArray];
    
    NSArray* tyreArray = specDictionary[@"Tyre-Size"];
    NSMutableArray* parsedTyreArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [tyreArray count]; i++) {
        NSDictionary* dict = [tyreArray objectAtIndex:i];
        BikeSpecification* specObj = [[BikeSpecification alloc] init];
        specObj.specification_category = @"Tyre Size";
        specObj.specification_title = [dict valueForKey:@"specification_title"];
        specObj.specification_value = [dict valueForKey:@"specification_value"];
        [parsedTyreArray addObject:specObj];
        specObj = nil;
    }
    Tyre * tyre = [[Tyre alloc] init];
    tyre.category_name = @"Tyre Size";
    tyre.specs = [[NSMutableArray alloc] initWithArray:parsedTyreArray];
    
    NSArray* brakeArray = specDictionary[@"Brake"];
    NSMutableArray* parsedBrakeArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [brakeArray count]; i++) {
        NSDictionary* dict = [brakeArray objectAtIndex:i];
        BikeSpecification* specObj = [[BikeSpecification alloc] init];
        specObj.specification_category = @"Brake";
        specObj.specification_title = [dict valueForKey:@"specification_title"];
        specObj.specification_value = [dict valueForKey:@"specification_value"];
        [parsedBrakeArray addObject:specObj];
        specObj = nil;
    }
    Brake* brake = [[Brake alloc] init];
    brake.category_name = @"Brake";
    brake.specs = [[NSMutableArray alloc] initWithArray:parsedBrakeArray];
    
    NSArray* dimensionArray = specDictionary[@"Dimensions"];
    NSMutableArray* parsedDimensionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [dimensionArray count]; i++) {
        NSDictionary* dict = [dimensionArray objectAtIndex:i];
        BikeSpecification* specObj = [[BikeSpecification alloc] init];
        specObj.specification_category = @"Dimensions";
        specObj.specification_title = [dict valueForKey:@"specification_title"];
        specObj.specification_value = [dict valueForKey:@"specification_value"];
        [parsedDimensionArray addObject:specObj];
        specObj = nil;
    }
    Dimensions* dimensions = [[Dimensions alloc] init];
    dimensions.category_name = @"Dimensions";
    dimensions.specs = [[NSMutableArray alloc] initWithArray:parsedDimensionArray];
    
    /*
    NSArray* specsArray = detailsDictionary[@"specification"];
    NSMutableArray* parsedSpecArray = [[NSMutableArray alloc] init];
    NSMutableDictionary* tempSpecsDict = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < [specsArray count]; i++) {
        tempSpecsDict = [specsArray objectAtIndex:i];
        BikeSpecification* bs = [[BikeSpecification alloc] init];
        bs.specification_title = [tempSpecsDict valueForKey:@"specification_title"];
        bs.specification_value = [tempSpecsDict valueForKey:@"specification_value"];
        [parsedSpecArray addObject:bs];
        tempSpecsDict = nil;
    }
    */
    NSArray* imagesArray = detailsDictionary[@"images"];
    NSMutableArray* parsedImagesArray  = [[NSMutableArray alloc] init];
    NSMutableDictionary* tempImagesDict = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < [imagesArray count]; i++) {
        tempImagesDict = [imagesArray objectAtIndex:i];
        BikeImage* bi = [[BikeImage alloc] init];
        bi.large_image_link = [tempImagesDict valueForKey:@"large_image_link"];
        bi.image_color = [tempImagesDict valueForKey:@"image_color"];
        [parsedImagesArray addObject:bi];
        tempImagesDict = nil;
    }
    /*
    SingleBikeDetails* sbk = [[SingleBikeDetails alloc] init];
    sbk.basic = bb;
    sbk.specs = parsedSpecArray;
    sbk.images = parsedImagesArray;*/
    
    SingleBikeDetails* sbk = [[SingleBikeDetails alloc] init];
    sbk.basic = bb;
    sbk.images = parsedImagesArray;
    
    sbk.engine = engine;
    sbk.electrical = electrical;
    sbk.suspension = suspension;
    sbk.tyre = tyre;
    sbk.brake = brake;
    sbk.dimensions = dimensions;
    
    BikeBasic* b = sbk.basic;
    NSLog(@"bike name: %@ bikecc: %@", b.bike_name, b.bike_cc);
    
    return sbk;
}

@end


@implementation BikeBasic

@synthesize bike_id, bike_code, bike_name, bike_cc, bike_mileage, thumble_img;

@end

@implementation BikeSpecification

@synthesize  specification_category,specification_title, specification_value;

@end

@implementation BikeImage

@synthesize large_image_link, image_color;

@end

@implementation Engine

@synthesize category_name, specs;

@end

@implementation Electrical

@synthesize category_name, specs;

@end

@implementation Suspension

@synthesize category_name, specs;

@end

@implementation Tyre

@synthesize category_name, specs;

@end

@implementation Brake

@synthesize category_name, specs;

@end

@implementation Dimensions

@synthesize category_name, specs;

@end

@implementation SingleBikeDetails

@synthesize basic, specs, images;
@synthesize engine, electrical, suspension, tyre, brake, dimensions;

-(NSInteger) rows{
    return engine.specs.count + electrical.specs.count + suspension.specs.count + tyre.specs.count + brake.specs.count + dimensions.specs.count + 18;
}

@end