//
//  Fav.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 30.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fav : NSObject
+(void)add:(NSDictionary*)master;
+(NSMutableDictionary*)all;
+(void)delete:(NSDictionary*)master;
+(BOOL)isFav:(NSDictionary*)master;

@end
