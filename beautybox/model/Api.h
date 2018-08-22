//
//  Api.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 14.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define USERINFO [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"]
#define TOKEN [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]

@interface Api : NSObject
+(void)registration:(NSDictionary*)params block:(void(^)(NSObject* result))block;
+(void)sendSMSWithToken:(NSString*)token phone:(NSString*)phone code:(NSString*)code block:(void(^)(NSObject* result))block;
+(void)sendSMSResetWithToken:(NSString*)token phone:(NSString*)phone code:(NSString*)code block:(void(^)(NSObject* result))block;
+(void)confirmSMSWithToken:(NSString*)token block:(void(^)(NSObject* result))block;
+(void)resetPasswordWithToken:(NSString*)token phone:(NSString*)phone password:(NSString*)password block:(void(^)(NSObject* result))block;

+(void)login:(NSDictionary*)params block:(void(^)(NSObject* result))block;
+(void)loginWithSM:(NSDictionary*)params block:(void(^)(NSObject* result))block;
+(void)loginWithSMWithVK:(BOOL)isVK userId:(NSString*)userId name:(NSString*)name block:(void(^)(NSObject* result))block;

+(void)categoryWithId:(NSString*)Id token:(NSString*)token block:(void(^)(NSObject* result))block;
+(void)mastersWithCatId:(NSString*)Id cityId:(NSString*)cityId block:(void(^)(NSObject* result))block;
+(void)mastersWithServiceId:(NSString*)Id categoryID:(NSString*)categoryID cityId:(NSString*)cityId page:(NSInteger)page block:(void(^)(NSObject* result))block;
+(void)mastersWithCatId:(NSString*)Id cityId:(NSString*)cityId page:(NSInteger)page block:(void(^)(NSObject* result))block;

+(void)citysGeoWithLocation:(CLLocation*)location token:(NSString*)token block:(void(^)(NSObject* result))block;
+(void)citysWithToken:(NSString*)token block:(void(^)(NSObject* result))block;
+(void)mastersWithServiceId:(NSString*)Id categoryID:(NSString*)categoryID cityId:(NSString*)cityId block:(void(^)(NSObject* result))block;

+(void)masterWithId:(NSString*)Id lock:(void(^)(NSObject* result))block;
+(void)masterAddFav:(NSString*)Id block:(void(^)(NSObject* result))block;
+(void)masterDeleteFav:(NSString*)Id block:(void(^)(NSObject* result))block;

@end
