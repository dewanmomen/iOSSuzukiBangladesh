//
//  APIURLs.h
//  Suzuki Bangladesh
//
//  Created by Anamul Habib on 4/5/16.
//  Copyright © 2016 ICE Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIURLsNdKeys : NSObject

//post request keys
//keys for getAuthKey request
extern NSString* const key_getAuthKey_unique_device_id;
extern NSString* const key_getAuthKey_notification_key;
extern NSString* const key_getAuthKey_platform;

//keys for getQuiz request
extern NSString* const key_getQuiz_authKey;

//keys for getMyBikeList request
extern NSString* const key_getMyBikeList_authKey;

//keys for getMyBikeDetails request
extern NSString* const key_getMyBikeDetails_authKey;
extern NSString* const key_getMyBikeDetails_bike_id;

//keys for user reg
extern NSString* const key_userReg_authKey;
extern NSString* const key_userReg_user_name;
extern NSString* const key_userReg_user_email;
extern NSString* const key_userReg_user_phone;
extern NSString* const key_userReg_address;
extern NSString* const key_userReg_password;
extern NSString* const key_userReg_thana;

//keys for user login
extern NSString* const key_userLogIn_auth_key;
extern NSString* const key_userLogIn_user_email;
extern NSString* const key_userLogIn_user_pass;

//keys for request for quotation
extern NSString* const key_rfq_auth_key;
extern NSString* const key_rfq_app_user_name;
extern NSString* const key_rfq_bike_id;
extern NSString* const key_rfq_bike_name;
extern NSString* const key_rfq_app_user_email;
extern NSString* const key_rfq_app_user_phone;
extern NSString* const key_rfq_app_user_address;
extern NSString* const key_rfq_app_user_comment;

//keys for request for services
extern NSString* const key_rfs_auth_key;
extern NSString* const key_rfs_app_user_id;
extern NSString* const key_rfs_bike_id;
extern NSString* const key_rfs_bike_name;
extern NSString* const key_rfs_service_type;
extern NSString* const key_rfs_servicing_type;
extern NSString* const key_rfs_service_option;
extern NSString* const key_rfs_cust_comment;

//keys for home gallery
extern NSString* const key_home_gallery_auth_key;

//keys for spare parts list
extern NSString* const key_spare_list_auth_key;

//keys for promoiton
extern NSString* const key_promotion_auth_key;

//keys for location
extern NSString* const key_location_auth_key;

//keys for media
extern NSString* const key_media_auth_key;

//keys for change password
extern NSString* const key_change_pass_auth_key;
extern NSString* const key_change_pass_old_password;
extern NSString* const key_change_pass_user_id;
extern NSString* const key_change_pass_new_password;

//keys for forget pass
extern NSString* const key_forget_pass_auth_key;
extern NSString* const key_forget_pass_user_id;
extern NSString* const key_forget_pass_user_email;

//keys for news nd event
extern NSString* const key_news_nd_event_auth_key;

//keys for notification list
extern NSString* const key_notification_auth_key;
//-------------------------


//methods that returns api url
//Get Authentication Key
+(NSString*) getAuthKeyURL;
//Get Quiz Data
+(NSString*) getQuizDataURL;
//Get My Bike List
+(NSString*) getMyBikeListURL;
//Get My Bike Details
+(NSString*) getMyBikeDetailsURL;
//user reg
+(NSString*) userRegURL;
//Sign in
+(NSString*) userLogInURL;
//Request for Quotation
+(NSString*) rfqURL;
//Request for Service URl
+(NSString*) rfsURL;
//home image gallery
+(NSString*) homeGalleryURL;
//spare list
+(NSString*) spareListURL;
//promotion
+(NSString*) promotionURL;
//location
+(NSString*) locationURL;
//media
+(NSString*) mediaURL;
//change pass url
+(NSString*) changePassURL;
//forget pass url
+(NSString*) forgetPassURL;
//news nd event url
+(NSString*) newsNdEventURL;
//notification list url
+(NSString*) notificationsListURL;
//-------------------------
@end
