//
//  NSDictionary+GalleryImage.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GalleryImage)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(NSArray*)getGalleryURL;
@end
