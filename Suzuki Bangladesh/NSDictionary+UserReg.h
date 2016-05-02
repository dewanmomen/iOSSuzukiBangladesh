//
//  NSDictionary+UserReg.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/18/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (UserReg)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;
-(NSString*)user_id;

- (NSString *)auth_key;

@end
