//
//  UrlPost.h
//  autoclubs
//
//  Created by CooLX on 26/01/16.
//  Copyright (c) 2016 CooLX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol UrlPostDelegate<NSObject>
@optional
- (void)didFinishURLPost:(NSObject*)object urlpost:(id)urlpost;
- (void)didFailURLPost:(NSObject*)object;

@end
@interface UrlPost : NSObject 
@property (nonatomic, retain)id <UrlPostDelegate> delegate;
-(void)request:(NSDictionary*)params headers:(NSDictionary*)headers urlString:(NSString*)urlString delegate2:(id<UrlPostDelegate>)delegate2 imgarr:(NSArray*)imgarr;
-(void)requestWithURL:(NSString*)urlString delegate:(id<UrlPostDelegate>)delegate2;
-(void)requestGetWithUrl:(NSString*)urlString delegate2:(id<UrlPostDelegate>)delegate2;

-(void)requestGetWithBlock:(NSString*)urlString block:(void(^)(NSObject* result))block;
-(void)requestPostWithBlock:(NSString*)urlString params:(NSMutableDictionary*)params block:(void(^)(NSObject* result))block;

-(void)requestWithMethod:(NSString*)method urlString:(NSString*)urlString params:(NSDictionary*)params delegate2:(id<UrlPostDelegate>)delegate2 block:(void(^)(NSObject* result,NSInteger code,NSString* body))block;
-(void)requestPostWithBlock:(NSString*)urlString image:(UIImage*)image fileName:(NSString*)fileName params:(NSMutableDictionary*)params block:(void(^)(NSObject* result))block;


 @end
