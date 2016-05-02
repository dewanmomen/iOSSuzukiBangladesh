//
//  NSDictionary+Rfs.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/25/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Rfs)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

@end
