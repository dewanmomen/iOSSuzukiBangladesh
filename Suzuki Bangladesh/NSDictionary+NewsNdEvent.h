//
//  NSDictionary+NewsNdEvent.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 5/1/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsNdEvent : NSObject

@property(nonatomic, strong) NSString* news_event_id;
@property(nonatomic, strong) NSString* type;
@property(nonatomic, strong) NSString* news_event_title;
@property(nonatomic, strong) NSString* news_event_desc;
@property(nonatomic, strong) NSString* news_event_img_url;
@property(nonatomic, strong) NSString* start_date;
@property(nonatomic, strong) NSString* end_date;

@end

@interface NSDictionary (NewsNdEvent)


- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

- (NSString *)auth_key;

-(NSArray*)getNewsNdEvent;


@end
