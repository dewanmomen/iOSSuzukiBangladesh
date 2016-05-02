//
//  NewsNdEventDetailVewController.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "NewsNdEventDetailVewController.h"
#import "UIImageView+AFNetworking.h"

#import "GlobalInstance.h"

@implementation NewsNdEventDetailVewController

@synthesize newsNdEventObj;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.constrDetailImageHeight.constant = [UIScreen mainScreen].bounds.size.width / .568;
    
    [self.detailImage setImageWithURL:[NSURL URLWithString:newsNdEventObj.news_event_img_url]];
    [self.detailTitle setText:newsNdEventObj.news_event_title];
    [self.detailsDesc setText:newsNdEventObj.news_event_desc];
}

@end
