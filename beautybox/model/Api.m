//
//  Api.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 14.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "Api.h"
#import "UrlPost.h"
#import "Singleton.h"

@implementation Api


+(void)registration:(NSDictionary*)params block:(void(^)(NSObject* result))block
{
    NSString *urlSring=[NSString stringWithFormat:@"%@/api/register_phone",[Singleton shared].domen];
    
    [[UrlPost alloc] requestPostWithBlock:urlSring params:params block:^(NSObject *result) {
        
        
        if([(NSDictionary*)result objectForKey:@"token"])
        {
            //[[NSUserDefaults standardUserDefaults] setObject:[(NSDictionary*)result objectForKey:@"token"] forKey:@"token"];
            //[[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        if([(NSDictionary*)result objectForKey:@"data"])
        {
            NSMutableDictionary *data=[NSMutableDictionary dictionaryWithDictionary:[(NSDictionary*)result objectForKey:@"data"]];
            
            for(NSString *key in data.allKeys)
            {
                NSObject *value=[data objectForKey:key];
                
                if([[data objectForKey:key] isEqual:[NSNull null]])
                    [data setObject:@"" forKey:key];
            }
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userinfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        block(result);
        
        
        
    }];
    
}


+(void)login:(NSDictionary*)params block:(void(^)(NSObject* result))block
{
    NSString *urlSring=[NSString stringWithFormat:@"%@/api/login/phone",[Singleton shared].domen];
    
    [[UrlPost alloc] requestPostWithBlock:urlSring params:params block:^(NSObject *result) {
        NSInteger status=[[(NSDictionary*)result objectForKey:@"status"] integerValue];
        
        if(status==200)
        {
        if([(NSDictionary*)result objectForKey:@"token"]
           &&[(NSDictionary*)result objectForKey:@"token"]!=[NSNull null])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[(NSDictionary*)result objectForKey:@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        if([(NSDictionary*)result objectForKey:@"data"])
        {
            NSMutableDictionary *data=[NSMutableDictionary dictionaryWithDictionary:[(NSDictionary*)result objectForKey:@"data"]];
            
            for(NSString *key in data.allKeys)
            {
                NSObject *value=[data objectForKey:key];
                
                if([[data objectForKey:key] isEqual:[NSNull null]])
                    [data setObject:@"" forKey:key];
            }
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userinfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        }
        block(result);
        
        
    }];
    
}


+(void)loginWithSMWithVK:(BOOL)isVK userId:(NSString*)userId name:(NSString*)name block:(void(^)(NSObject* result))block
{
    NSString *urlSring=[NSString stringWithFormat:@"%@/api/login/social",[Singleton shared].domen];
    
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setObject:isVK?@"1":@"2" forKey:@"providerID"];
    [params setObject:userId forKey:@"providerToken"];
    [params setObject:name forKey:@"name"];

    [[UrlPost alloc] requestPostWithBlock:urlSring params:params block:^(NSObject *result) {
        NSInteger status=[[(NSDictionary*)result objectForKey:@"status"] integerValue];
        
        if(status==200)
        {
            if([(NSDictionary*)result objectForKey:@"token"]
               &&[(NSDictionary*)result objectForKey:@"token"]!=[NSNull null])
            {
                [[NSUserDefaults standardUserDefaults] setObject:[(NSDictionary*)result objectForKey:@"token"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            if([(NSDictionary*)result objectForKey:@"data"])
            {
                NSMutableDictionary *data=[NSMutableDictionary dictionaryWithDictionary:[(NSDictionary*)result objectForKey:@"data"]];
                
                for(NSString *key in data.allKeys)
                {
                    NSObject *value=[data objectForKey:key];
                    
                    if([[data objectForKey:key] isEqual:[NSNull null]])
                        [data setObject:@"" forKey:key];
                }
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userinfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
        }
        block(result);
        
    }];
    
}


+(void)sendSMSWithToken:(NSString*)token phone:(NSString*)phone code:(NSString*)code block:(void(^)(NSObject* result))block
{
    
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(token)
    [params setObject:token forKey:@"token"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code forKey:@"code"];

    NSString *urlString=[NSString stringWithFormat:@"%@/api/sms_send?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}

+(void)sendSMSResetWithToken:(NSString*)token phone:(NSString*)phone code:(NSString*)code block:(void(^)(NSObject* result))block
{
    
    NSMutableDictionary *params=[NSMutableDictionary new];
    if(token)
        [params setObject:token forKey:@"token"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:code forKey:@"code"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/password/phone?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}

+(void)resetPasswordWithToken:(NSString*)token phone:(NSString*)phone password:(NSString*)password block:(void(^)(NSObject* result))block
{
    NSString *urlSring=[NSString stringWithFormat:@"%@/api/password/reset",[Singleton shared].domen];
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(token)
    [params setObject:token forKey:@"token"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:password forKey:@"password"];
    [params setObject:password forKey:@"passwordConfirm"];

    [[UrlPost alloc] requestPostWithBlock:urlSring params:params block:^(NSObject *result) {
        
        block(result);
        
    }];
    
}

+(void)confirmSMSWithToken:(NSString*)token block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    if(token)
    [params setObject:token forKey:@"token"];
    NSString *urlString=[NSString stringWithFormat:@"%@/api/sms_confirm?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}


+(void)categoryWithId:(NSString*)Id token:(NSString*)token block:(void(^)(NSObject* result))block
{
    
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(token)
    [params setObject:token forKey:@"token"];
    [params setObject:Id?:@"" forKey:@"categoryID"];

    NSString *urlString=[NSString stringWithFormat:@"%@/api/category?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestPostWithBlock:urlString params:params block:^(NSObject *result) {
        
        block(result);
        
    }];
}

+(void)citysGeoWithLocation:(CLLocation*)location token:(NSString*)token block:(void(^)(NSObject* result))block
{
    
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(token)
    [params setObject:token forKey:@"token"];
    [params setObject:[NSString stringWithFormat:@"%f,%f", location.coordinate.longitude,location.coordinate.latitude] forKey:@"coords"];

    NSString *urlString=[NSString stringWithFormat:@"%@/api/city_geo?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestPostWithBlock:urlString params:params block:^(NSObject *result) {
        
        block(result);
        
    }];
}


+(void)citysWithToken:(NSString*)token block:(void(^)(NSObject* result))block
{
    
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(token)
    [params setObject:token forKey:@"token"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/cities?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestPostWithBlock:urlString params:params block:^(NSObject *result) {
        
        block(result);
        
    }];
}




+(void)mastersWithServiceId:(NSString*)Id categoryID:(NSString*)categoryID cityId:(NSString*)cityId block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    if(TOKEN)
        [params setObject:TOKEN forKey:@"token"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];

    [params setObject:Id forKey:@"serviceID"];
    [params setObject:categoryID forKey:@"categoryID"];
    [params setObject:cityId forKey:@"cityID"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/users_service?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}

+(void)mastersWithCatId:(NSString*)Id cityId:(NSString*)cityId page:(NSInteger)page block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    if(TOKEN)
        [params setObject:TOKEN forKey:@"token"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];
    
    [params setObject:[NSString stringWithFormat:@"%ld", (page-1)*10] forKey:@"skip"];
    [params setObject:Id forKey:@"categoryID"];
    [params setObject:cityId forKey:@"cityID"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/users_category?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}



+(void)mastersWithServiceId:(NSString*)Id categoryID:(NSString*)categoryID cityId:(NSString*)cityId page:(NSInteger)page block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(TOKEN)
    [params setObject:TOKEN forKey:@"token"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];
    [params setObject:[NSString stringWithFormat:@"%ld", (page-1)*10] forKey:@"skip"];

    [params setObject:Id forKey:@"serviceID"];
    [params setObject:categoryID forKey:@"categoryID"];
    [params setObject:cityId forKey:@"cityID"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/users_service?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}

+(void)mastersWithCatId:(NSString*)Id cityId:(NSString*)cityId block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(TOKEN)
    [params setObject:TOKEN forKey:@"token"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];
    
    [params setObject:Id forKey:@"categoryID"];
    [params setObject:cityId forKey:@"cityID"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/users_category?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}

+(void)masterAddFav:(NSString*)Id block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    if(TOKEN)
        [params setObject:TOKEN forKey:@"token"];
    [params setObject:Id forKey:@"masterID"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/favorite_add?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        block(result);
    }];
}

+(void)masterDeleteFav:(NSString*)Id block:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
    if(TOKEN)
        [params setObject:TOKEN forKey:@"token"];
    [params setObject:Id forKey:@"masterID"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/favorite_remove?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        block(result);
    }];
}

+(void)masterWithId:(NSString*)Id lock:(void(^)(NSObject* result))block
{
    NSMutableDictionary *params=[NSMutableDictionary new];
        if(TOKEN)
    [params setObject:TOKEN forKey:@"token"];
    [params setObject:Id forKey:@"masterID"];
    if([USERINFO objectForKey:@"userID"])
        [params setObject:[USERINFO objectForKey:@"userID"] forKey:@"userID"];
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/api/user?",[Singleton shared].domen];
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    
    [[UrlPost alloc] requestGetWithBlock:urlString block:^(NSObject *result) {
        
        block(result);
    }];
}

@end
