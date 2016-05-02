//
//  GlobalInstance.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/5/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "NSDictionary+AuthKey.h"
#import "NSDictionary+QuizData.h"
#import "NSDictionary+BikeList.h"
#import "NSDictionary+BikeDetails.h"
#import "NSDictionary+UserReg.h"
#import "NSDictionary+UserLogIn.h"
#import "NSDictionary+RfQ.h"
#import "NSDictionary+Rfs.h"
#import "NSDictionary+SpareParts.h"
#import "NSDictionary+GalleryImage.h"
#import "NSDictionary+Promotion.h"
#import "NSDictionary+Location.h"
#import "NSDictionary+MediaURLs.h"
#import "NSDictionary+NewsNdEvent.h"
#import "NSDictionary+Notifications.h"
#import "NSDictionary+ChangePassword.h"
#import "NSDictionary+ForgotPass.h"

//@class AuthKey;

@interface GlobalInstance : NSObject{
    BOOL isLoggedin;
}

extern NSString* const font_suzuki_regular;
extern NSString* const font_suzuki_bold;
extern NSString* const font_font_awesome_yay;

+ (GlobalInstance *) sharedInstance;

@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) NSDictionary *authKeyJSON;
@property (nonatomic, strong) NSDictionary *quizJSON;
@property (nonatomic, strong) NSDictionary *bikeListJSON;
@property (nonatomic, strong) NSDictionary *bikeDetailsJSON;
@property (nonatomic, strong) NSDictionary *userRegJSON;
@property (nonatomic, strong) NSDictionary *userLogInJSON;
@property (nonatomic, strong) NSDictionary *rfqJSON;
@property (nonatomic, strong) NSDictionary *rfsJSON;
@property (nonatomic, strong) NSDictionary *spareJSON;
@property (nonatomic, strong) NSDictionary *homeGalleryJSON;
@property (nonatomic, strong) NSDictionary *promotionJSON;
@property (nonatomic, strong) NSDictionary *locationJSON;
@property (nonatomic, strong) NSDictionary *mediaJSON;
@property (nonatomic, strong) NSDictionary *newsNdEventJSON;
@property (nonatomic, strong) NSDictionary *notificationsListJSON;
@property (nonatomic, strong) NSDictionary *changePasswordJSON;
@property (nonatomic, strong) NSDictionary *forgotPasswordJSON;


@property (nonatomic, strong) NSMutableArray *itemsInCart;

@property (nonatomic, assign) BOOL isLoggedin;
@property (nonatomic, assign) NSString* auth_key;
@property (nonatomic, assign) NSString* user_id;

@end
