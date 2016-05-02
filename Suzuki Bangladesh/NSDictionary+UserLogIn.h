//
//  NSDictionary+UserLogIn.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/20/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (UserLogIn)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

-(NSString*) user_id;
@end
