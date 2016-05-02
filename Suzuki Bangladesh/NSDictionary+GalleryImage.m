//
//  NSDictionary+GalleryImage.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+GalleryImage.h"

@implementation NSDictionary (GalleryImage)

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

-(NSArray*)getGalleryURL{
    
    NSArray* galleryArray = self[@"gallery"];
    NSMutableArray* parsedArrayOfUrl = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [galleryArray count]; i++) {
        NSDictionary* tempDict = [galleryArray objectAtIndex:i];
        
        [parsedArrayOfUrl addObject:[tempDict valueForKey:@"g_image" ]];
    }
    return parsedArrayOfUrl;
}

@end
