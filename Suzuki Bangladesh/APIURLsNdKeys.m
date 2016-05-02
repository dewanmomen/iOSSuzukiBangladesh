//
//  APIURLs.m
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/5/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import "APIURLsNdKeys.h"

@implementation APIURLsNdKeys

//base URL and Endpoints

//base URL
static NSString* const baseURL = @"http://icebd.com/suzuki/suzukiApi/server/";

//Endpoints
//get auth key
static NSString* const getAuthKeyEndPoint = @"getAuthKey";
//get quiz data
static NSString* const getQuizEndPoint = @"getquizDetail";
//get my bike list
static NSString* const getMyBikeListEndPoint = @"getBikeList";
//get my bike details
static NSString* const getMyBikeDetailsEndPoint = @"getBikeDetail";
//user reg
static NSString* const userRegEndPoint = @"registerUser";
//user login
static NSString* const userLogInEndPoint = @"login";
//request for quotation
static NSString* const rfqEndPoint = @"reqQuotation";
//request for service
static NSString* const rfsEndPoint = @"reqService";
//home image gallery
static NSString* const homeImageGalleryEndPoint = @"getGallery";
//spare list
static NSString* const spareListEndPoint = @"spareList";
//promotion
static NSString* const promotionEndPoint = @"promoInfo";
//location
static NSString* const locationEndPoint = @"getLocation";
//media
static NSString* const mediaEndPoint = @"getMedia";
//change pass
static NSString* const changePassEndPoint = @"changePassword";
//forget pass
static NSString* const forgetPassEndPoint = @"forgetPassword";
//news nd event
static NSString* const newsNdEventEndPoint = @"newsList";
//get notification list
static NSString* const notificationListEndPoint = @"getAllnotification";
//-------------------------


//methods that returns api url
+(NSString*) getAuthKeyURL{
    return [baseURL stringByAppendingString:getAuthKeyEndPoint];
}

+(NSString*) getQuizDataURL{
    return [baseURL stringByAppendingString:getQuizEndPoint];
}

+(NSString*) getMyBikeListURL{
    return [baseURL stringByAppendingString:getMyBikeListEndPoint];
}

+(NSString*) getMyBikeDetailsURL{
    return [baseURL stringByAppendingString:getMyBikeDetailsEndPoint];
}

+(NSString*) userRegURL{
    return [baseURL stringByAppendingString:userRegEndPoint];
}

+(NSString*) userLogInURL{
    return [baseURL stringByAppendingString:userLogInEndPoint];
}

+(NSString*) rfqURL{
    return [baseURL stringByAppendingString:rfqEndPoint];
}

+(NSString*) rfsURL{
    return [baseURL stringByAppendingString:rfsEndPoint];
}

+(NSString*) homeGalleryURL{
    return [baseURL stringByAppendingString:homeImageGalleryEndPoint];
}

+(NSString*) spareListURL{
    return [baseURL stringByAppendingString:spareListEndPoint];
}
+(NSString*) promotionURL{
    return [baseURL stringByAppendingString:promotionEndPoint];
}
+(NSString*) locationURL{
    return [baseURL stringByAppendingString:locationEndPoint];
}
+(NSString*) mediaURL{
    return [baseURL stringByAppendingString:mediaEndPoint];
}
+(NSString*) changePassURL{
    return [baseURL stringByAppendingString:changePassEndPoint];
}
+(NSString*) forgetPassURL{
    return [baseURL stringByAppendingString:forgetPassEndPoint];
}
+(NSString*) newsNdEventURL{
    return [baseURL stringByAppendingString:newsNdEventEndPoint];
}
+(NSString*) notificationsListURL{
    return [baseURL stringByAppendingString:notificationListEndPoint];
}
//-------------------------


//post request keys
NSString* const key_getAuthKey_unique_device_id = @"unique_device_id";
NSString* const key_getAuthKey_notification_key = @"notification_key";
NSString* const key_getAuthKey_platform = @"platform";

NSString* const key_getQuiz_authKey = @"auth_key";

NSString* const key_getMyBikeList_authKey = @"auth_key";

NSString* const key_getMyBikeDetails_authKey = @"auth_key";
NSString* const key_getMyBikeDetails_bike_id = @"bike_id";

NSString* const key_userReg_authKey = @"auth_key";
NSString* const key_userReg_user_name = @"app_user_name";
NSString* const key_userReg_user_email = @"app_user_email";
NSString* const key_userReg_user_phone = @"app_user_phone";
NSString* const key_userReg_address = @"app_user_address";
NSString* const key_userReg_password = @"app_user_password";
NSString* const key_userReg_thana = @"app_user_thana";

NSString* const key_userLogIn_auth_key = @"auth_key";
NSString* const key_userLogIn_user_email = @"user_email";
NSString* const key_userLogIn_user_pass = @"user_pass";

NSString* const key_rfq_auth_key = @"auth_key";
NSString* const key_rfq_app_user_name = @"app_user_name";
NSString* const key_rfq_bike_id = @"bike_id";
NSString* const key_rfq_bike_name = @"bike_name";
NSString* const key_rfq_app_user_email = @"app_user_email";
NSString* const key_rfq_app_user_phone = @"app_user_phone";
NSString* const key_rfq_app_user_address = @"app_user_address";
NSString* const key_rfq_app_user_comment = @"app_user_comment";

NSString* const key_rfs_auth_key = @"auth_key";
NSString* const key_rfs_app_user_id = @"app_user_id";
NSString* const key_rfs_bike_id = @"bike_id";
NSString* const key_rfs_bike_name = @"bike_name";
NSString* const key_rfs_service_type = @"service_type";
NSString* const key_rfs_servicing_type = @"servicing_type";
NSString* const key_rfs_service_option = @"service_option";
NSString* const key_rfs_cust_comment = @"cust_comment";

NSString* const key_home_gallery_auth_key = @"auth_key";

NSString* const key_spare_list_auth_key = @"auth_key";

NSString* const key_promotion_auth_key = @"auth_key";

NSString* const key_location_auth_key = @"auth_key";

NSString* const key_media_auth_key = @"auth_key";

NSString* const key_change_pass_auth_key = @"auth_key";
NSString* const key_change_pass_old_password = @"old_password";
NSString* const key_change_pass_user_id = @"user_id";
NSString* const key_change_pass_new_password = @"new_password";

NSString* const key_forget_pass_auth_key = @"auth_key";
NSString* const key_forget_pass_user_id = @"user_id";
NSString* const key_forget_pass_user_email = @"user_email";

NSString* const key_news_nd_event_auth_key = @"auth_key";

NSString* const key_notification_auth_key = @"auth_key";
//-------------------------
@end
