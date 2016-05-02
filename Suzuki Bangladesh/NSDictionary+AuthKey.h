//
//  NSDictionary+AuthKey.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/5/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AuthKey)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

@end
