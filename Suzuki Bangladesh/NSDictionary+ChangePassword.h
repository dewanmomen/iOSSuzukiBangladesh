//
//  NSDictionary+ChangePassword.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ChangePassword)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

@end
