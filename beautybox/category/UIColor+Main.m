//
//  UIColor+Main.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 13.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "UIColor+Main.h"

@implementation UIColor (Main)

+(UIColor*)orange
{
    return [self colorFromHexString:@"FB816D"];
}


+(UIColor*)yelow
{
    return [UIColor colorFromHexString:@"ffbd12"];
}

+(UIColor*)lightGray
{
    return [UIColor colorFromHexString:@"EBEBEB"];

}

+(UIColor*)graTextField
{
    return [UIColor colorFromHexString:@"E9E9E9"];
    
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
@end
