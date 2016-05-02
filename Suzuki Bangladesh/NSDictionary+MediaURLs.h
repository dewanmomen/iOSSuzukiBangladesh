//
//  NSDictionary+MediaURLs.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaLinks : NSObject

@property(nonatomic, strong) NSString* media_id;
@property(nonatomic, strong) NSString* play_store;
@property(nonatomic, strong) NSString* fb;
@property(nonatomic, strong) NSString* app_store;

@end


@interface NSDictionary (MediaURLs)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(MediaLinks*) getMediaLinks;

@end


