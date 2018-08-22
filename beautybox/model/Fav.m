//
//  Fav.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 30.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "Fav.h"

@implementation Fav

+(void)add:(NSDictionary*)master
{
    NSMutableDictionary *arr=[self all];
    if([ self isFav:master])
    {
        [arr removeObjectForKey:[NSString stringWithFormat:@"%@",[master objectForKey:@"userID"]]];
    }
    else
    {
        [arr setObject:master forKey:[NSString stringWithFormat:@"%@", [master objectForKey:@"userID"]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"fav"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)delete:(NSDictionary*)master
{
    NSMutableDictionary *arr=[self all];
    [arr removeObjectForKey:[master objectForKey:@"userID"]];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"fav"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSMutableDictionary*)all
{
    NSMutableDictionary *arr=[[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"fav"]];
    
    return arr;
}

+(BOOL)isFav:(NSDictionary*)master
{
    BOOL res=NO;
    NSMutableDictionary *arr=[self all];
    if([arr objectForKey:[NSString stringWithFormat:@"%@", [master objectForKey:@"userID"]]])
        res=YES;
    return res;
}
@end
