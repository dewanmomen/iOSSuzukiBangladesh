//
//  NSDictionary+QuizData.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/10/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NSDictionary+QuizData.h"

@implementation NSDictionary (QuizData)


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
-(NSArray*) quizes{
    NSDictionary* quizes = self[@"quizes"];
    NSArray* questions = quizes[@"questions"];
    
    NSMutableArray* alltheQuestions = [[NSMutableArray alloc] init];
    //NSLog(@"questions: %@ and size: %i", [questions description], [questions count]);
    
    QuizQuestion* singleQuizQuestion = [[QuizQuestion alloc] init];
    
    NSMutableDictionary* aQues;
    NSMutableArray* optionArray;
    NSMutableDictionary* optionDictionary;
    NSMutableArray* parsedOptionArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [questions count]; i++) {
        aQues = [questions objectAtIndex:i];
        singleQuizQuestion.question_id = [aQues valueForKey:@"question_id"];
        singleQuizQuestion.question = [aQues valueForKey:@"question" ];
        NSLog(@"question from parser %@", singleQuizQuestion.question);
        optionArray = aQues[@"options"];
        for (int j = 0; j < [optionArray count]; j++) {
            NSArray* ar = [optionArray objectAtIndex:j];
            NSLog(@"that test array: %@", ar);
            optionDictionary = [optionArray objectAtIndex:j];
            QuizOption* qo = [[QuizOption alloc] init];
            qo.option_id = [optionDictionary valueForKey:@"option_id"];
            qo.option = [optionDictionary valueForKey:@"option"];
            [parsedOptionArray addObject:qo];
            //[singleQuizQuestion.options addObject:qo];
            //[optionDictionary removeAllObjects];
            optionDictionary = nil;
        }
        //NSLog(@"after for loop: %lu", (unsigned long)[parsedOptionArray count]);
        //singleQuizQuestion.options = parsedOptionArray;
        singleQuizQuestion.options = [[NSMutableArray alloc] initWithArray:parsedOptionArray];
        //parsedOptionArray = nil;
        [alltheQuestions addObject:singleQuizQuestion];
        singleQuizQuestion = [[QuizQuestion alloc] init];
        [parsedOptionArray removeAllObjects];
        //[aQues removeAllObjects];
        aQues = nil;
    }
    //QuizQuestion* qq = [alltheQuestions objectAtIndex:1];
    //QuizOption* qo = [qq.options objectAtIndex:1];
    //NSLog(@"oh really: %@", qo.option);
    return alltheQuestions;//[alltheQuestions mutableCopy];
}

-(NSString*) title{
    NSDictionary* quizes = self[@"quizes"];
    return quizes[@"title"];
}
-(NSString*) description{
    NSDictionary* quizes = self[@"quizes"];
    return quizes[@"description"];
}
-(NSString*) start{
    NSDictionary* quizes = self[@"quizes"];
    return quizes[@"start"];
}
-(NSString*) end{
    NSDictionary* quizes = self[@"quizes"];
    return quizes[@"end"];
}

@end


@implementation QuizOption

@synthesize option_id, option;

@end


@implementation QuizQuestion

@synthesize question_id, question;

@end
