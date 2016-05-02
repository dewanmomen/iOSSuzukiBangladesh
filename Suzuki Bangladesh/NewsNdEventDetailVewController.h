//
//  NewsNdEventDetailVewController.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/30/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+NewsNdEvent.h"

@interface NewsNdEventDetailVewController : UIViewController

@property (nonatomic, strong) NewsNdEvent* newsNdEventObj;


@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrDetailImageHeight;

@property (weak, nonatomic) IBOutlet UILabel *detailTitle;

@property (weak, nonatomic) IBOutlet UITextView *detailsDesc;

@end
