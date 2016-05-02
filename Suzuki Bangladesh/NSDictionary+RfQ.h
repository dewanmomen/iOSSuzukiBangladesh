//
//  NSDictionary+RfQ.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/24/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RfQ)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

@end
