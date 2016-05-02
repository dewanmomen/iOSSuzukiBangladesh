//
//  NSDictionary+UserLogIn.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/20/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+UserLogIn.h"

@implementation NSDictionary (UserLogIn)

- (NSNumber *)status_code{
    return @([self[@"status_code"] intValue]);
}
- (NSString *)auth_key{
    return self[@"auth_key"];
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

-(NSString*) user_id{
    return self[@"user_id"];
}

@end
