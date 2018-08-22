//
//  UrlPost.m
//  autoclubs
//
//  Created by CooLX on 26/01/16.
//  Copyright (c) 2016 CooLX. All rights reserved.
//

#import "UrlPost.h"
#import "Singleton.h"
#import "Api.h"

@implementation UrlPost
NSURLConnection *connection;
NSMutableData *dataURL;
@synthesize delegate;

//main method url requests
-(void)requestWithMethod:(NSString*)method urlString:(NSString*)urlString params:(NSDictionary*)params delegate2:(id<UrlPostDelegate>)delegate2 block:(void(^)(NSObject* result,NSInteger code,NSString* body))block
{
    NSString *boundary = @"------WebKitFormBoundaryFBLMONRjXm0pCyW7";
    delegate=delegate2;
    if(params!=nil)
        urlString=[urlString stringByAppendingString:@"?"];
    
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:5.0];


    [request setHTTPMethod:method];
 
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];


    NSMutableData *postData=[[NSMutableData alloc] init];
    
    for (NSString *param in params) {
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postData appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
     
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        //[bodytext appendString:[NSString stringWithFormat:@"--%@\r\n", boundary]];
    
    
    
  
        if([method isEqualToString:@"POST"])
    [request setHTTPBody:postData];
    
    NSString *content =[ NSString stringWithCString:[postData bytes] encoding:NSUTF8StringEncoding];

    NSLog(@"метод:%@\nтело%@",urlString,content);
    
    if(!block)
    {
    dataURL  =[NSMutableData data];
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    else
    {
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *_response, NSData *_data, NSError *_error) {
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) _response;
                                   NSLog(@"http code - %ld",(long)httpResponse.statusCode);
                                   if(_error==nil)
                                   {
                                       NSError *error;
                                       NSString *sting=[NSString stringWithUTF8String:[_data bytes]];
                                       NSLog(@"%@", sting);
                                       
                                       NSObject *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:&error];
                                       block(dict,httpResponse.statusCode, sting);
                                       
                                   }
                                   else
                                   {
                                       block(nil,0, nil);
                                   }
                                       
                                   
                               }];
    }
}

-(void)requestWithImage:(UIImage*)image fileName:(NSString*)fileName urlString:(NSString*)urlString params:(NSDictionary*)params block:(void(^)(NSObject* result,NSInteger code,NSString* body))block
{
    NSString *boundary = @"------WebKitFormBoundaryFBLMONRjXm0pCyW7";
    if(params!=nil)
        urlString=[urlString stringByAppendingString:@"?"];
    
    for(NSString *key in params)
    {
        urlString=[urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[params objectForKey:key]]];
    }
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"multipart/form-data;boundary=------WebKitFormBoundaryFBLMONRjXm0pCyW7" forHTTPHeaderField:@"Content-Type"];

    NSMutableData *postData=[[NSMutableData alloc] init];
    
    if (image)
    {
        NSData *imagedata=[[NSData alloc] init];
        imagedata=UIImageJPEGRepresentation( image, .33f);
        
        [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n",fileName, TOKEN] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:imagedata];
        [postData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];    
    [request setHTTPBody:postData];
    
    NSString *content =[ NSString stringWithCString:[postData bytes] encoding:NSUTF8StringEncoding];
    
    NSLog(@"метод:%@\nтело%@",urlString,content);
    
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *_response, NSData *_data, NSError *_error) {
                                   NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) _response;
                                   NSLog(@"http code - %ld",(long)httpResponse.statusCode);
                                   if(_error==nil)
                                   {
                                       NSError *error;
                                       NSString *sting=[NSString stringWithUTF8String:[_data bytes]];
                                       
                                       NSLog(@"%@", sting);
                                       
                                       NSObject *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:&error];
                                       block(dict,httpResponse.statusCode, sting);
                                       
                                   }
                                   else
                                   {
                                       block(nil,nil, nil);
                                   }
                                   
                                   
                               }];

}


//method for public api
-(void)requestWithURL:(NSString*)urlString delegate:(id<UrlPostDelegate>)delegate2
{
    delegate=delegate2;
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30.0];
    dataURL  =[NSMutableData data];
    connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataURL appendData:data];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
 
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    NSInteger code= httpResponse.statusCode;
    if(code==401)
    {
        NSLog(@"Ошибка авторизации");
    }
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dictionary = [httpResponse allHeaderFields];
        NSLog(@"%@", [dictionary description]);
    }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *sting=[NSString stringWithUTF8String:[dataURL bytes]];
        if(sting)
            NSLog(@"%@", [sting description]);
    
    NSObject *response= [NSJSONSerialization JSONObjectWithData:dataURL options:kNilOptions error:nil];
    if(response!=nil)
        NSLog(@"%@", [response description]);

    if (delegate && [delegate respondsToSelector:@selector(didFinishURLPost:urlpost:)])
    {
        [delegate performSelector:@selector(didFinishURLPost:urlpost:) withObject:response withObject:self];
    }
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
     if (delegate && [delegate respondsToSelector:@selector(didFailURLPost:)])
    {
        [delegate performSelector:@selector(didFailURLPost:) withObject:error];
    }
}


-(void)request:(NSDictionary*)params headers:(NSDictionary*)headers urlString:(NSString*)urlString delegate2:(id<UrlPostDelegate>)delegate2 imgarr:(NSArray*)imgarr
{
    
    [self requestWithMethod:@"POST" urlString:urlString params:params delegate2:delegate2 block:nil];
}



-(void)requestGetWithUrl:(NSString*)urlString delegate2:(id<UrlPostDelegate>)delegate2
{
    
    [self requestWithMethod:@"GET" urlString:urlString params:nil delegate2:delegate2 block:nil];
    
}


-(void)requestGetWithBlock:(NSString*)urlString block:(void(^)(NSObject* result))block
{
    [self requestWithMethod:@"GET" urlString:urlString params:nil delegate2:nil block:^(NSObject *result, NSInteger code, NSString *body) {
        block(result);
    }];
    
}


-(void)requestPostWithBlock:(NSString*)urlString image:(UIImage*)image fileName:(NSString*)fileName params:(NSMutableDictionary*)params block:(void(^)(NSObject* result))block
{
    if(TOKEN)
        [params setObject:TOKEN forKey:@"token"];
    [self requestWithImage:image fileName:fileName urlString:urlString params:params block:^(NSObject *result, NSInteger code, NSString *body) {
        block(result);
    }];
}

-(void)requestPostWithBlock:(NSString*)urlString params:(NSMutableDictionary*)params block:(void(^)(NSObject* result))block
{
    if(TOKEN)
        [params setObject:TOKEN forKey:@"token"];
    [self requestWithMethod:@"POST" urlString:urlString params:params delegate2:nil block:^(NSObject *result, NSInteger code, NSString *body) {
        block(result);
    }];
}


 

@end
