//
//  NSDictionary+NewsNdEvent.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 5/1/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+NewsNdEvent.h"

@implementation NSDictionary (NewsNdEvent)


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

-(NSArray*)getNewsNdEvent{
    NSArray* newsNdEventArray = self[@"news"];
    NSLog(@"main array size: %lu", [newsNdEventArray count]);
    NSMutableArray* parsedNewsNdEvent = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [newsNdEventArray count]; i++) {
        NSDictionary* tempDict = [newsNdEventArray objectAtIndex:i];
        
        NewsNdEvent* nNe = [[NewsNdEvent alloc] init];
        
        nNe.news_event_id = [tempDict valueForKey:@"news_event_id"];
        nNe.type  = [tempDict valueForKey:@"type"];
        nNe.news_event_title  = [tempDict valueForKey:@"news_event_title"];
        nNe.news_event_desc = [tempDict valueForKey:@"news_event_desc"];
        nNe.news_event_img_url  = [tempDict valueForKey:@"news_event_img_url"];
        nNe.start_date  = [tempDict valueForKey:@"start_date"];
        nNe.end_date  = [tempDict valueForKey:@"end_date"];
        
        NSLog(@"news title: %@", nNe.news_event_title);
        [parsedNewsNdEvent addObject:nNe];
        
    }
    NSLog(@"news size from parser: %lu", (unsigned long)[parsedNewsNdEvent count]);
    return parsedNewsNdEvent;
}
@end


@implementation NewsNdEvent

@synthesize news_event_id, type, news_event_title, news_event_desc, news_event_img_url, start_date, end_date;

@end