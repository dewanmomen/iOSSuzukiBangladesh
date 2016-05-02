//
//  GlobalInstance.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/5/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "GlobalInstance.h"

@implementation GlobalInstance

@synthesize activityView = _activityView;
@synthesize authKeyJSON;
@synthesize quizJSON;
@synthesize bikeListJSON;
@synthesize bikeDetailsJSON;
@synthesize userRegJSON;
@synthesize userLogInJSON;
@synthesize rfqJSON;
@synthesize rfsJSON;
@synthesize spareJSON;
@synthesize homeGalleryJSON;
@synthesize promotionJSON;
@synthesize locationJSON;
@synthesize mediaJSON;
@synthesize newsNdEventJSON;
@synthesize notificationsListJSON;
@synthesize changePasswordJSON;
@synthesize forgotPasswordJSON;

@synthesize isLoggedin, auth_key, user_id;

NSString* const font_suzuki_regular = @"SuzukiPRORegular";
NSString* const font_suzuki_bold = @"SuzukiPROBold";
NSString* const font_font_awesome_yay = @"FontAwesome";

static GlobalInstance *_sharedInstance = NULL;

+ (GlobalInstance *) sharedInstance{
    @synchronized(_sharedInstance)
    {
        if (!_sharedInstance || _sharedInstance == NULL) {
            _sharedInstance = [[GlobalInstance alloc] init];
            
            _sharedInstance.isLoggedin = false;
            _sharedInstance.auth_key = @"";
            _sharedInstance.user_id = @"";
            
        }
    }
    
    return _sharedInstance;
}

-(UIActivityIndicatorView*) activityView{
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //_activityView.color = [UIColor colorWithRed:216.0/255.0 green:39.0/255.0 blue:47.0/255.0 alpha:1];
    
    return _activityView;
}

@end
