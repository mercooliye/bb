//
//  Singleton.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+Utils.h"
#define cityID [[NSUserDefaults standardUserDefaults] objectForKey:@"cityID"]
#define cityName [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"]
#define api_key @"AIzaSyCBnZle8qYqQxDnPNqUzD5qr6cYD3W_Vf8"
@interface Singleton : NSObject
@property NSString *domen;
+(Singleton *)shared;

@end
