//
//  NSDictionary+QuizData.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/10/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QuizData)

- (NSNumber *)status_code;
- (NSString *)message;
- (BOOL)status;

-(NSString*) title;
-(NSString*) description;
-(NSString*) start;
-(NSString*) end;

-(NSArray*) quizes;

@end


@interface QuizOption : NSObject

@property(nonatomic, strong) NSString* option_id;
@property(nonatomic, strong) NSString* option;

@end


@interface QuizQuestion : NSObject

@property(nonatomic, strong) NSString* question_id;
@property(nonatomic, strong) NSString* question;
@property(nonatomic, strong) NSMutableArray* options;

@end