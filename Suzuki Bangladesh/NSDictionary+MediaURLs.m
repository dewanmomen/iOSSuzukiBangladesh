//
//  NSDictionary+MediaURLs.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/26/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+MediaURLs.h"


@implementation MediaLinks

@synthesize media_id, play_store, fb, app_store;

@end


@implementation NSDictionary (MediaURLs)

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

-(MediaLinks*) getMediaLinks{
    
    NSArray* linksArray = self[@"link"];
    
    NSDictionary* linksDict = [linksArray objectAtIndex:0];
    
    MediaLinks* ml = [[MediaLinks alloc] init];
    
    ml.media_id = [linksDict valueForKey:@"media_id"];
    ml.play_store = [linksDict valueForKey:@"play_store"];
    ml.fb = [linksDict valueForKey:@"fb"];
    ml.app_store = [linksDict valueForKey:@"app_store"];
    
    return ml;
}


@end


