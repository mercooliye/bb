//
//  NSString+Ending.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 08.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "NSString+Ending.h"

@implementation NSString (Ending)


+(NSString*)getWorkByDeclension:(int)number :(NSArray*)arrayWords{
    NSString* resultString = @"";
    number = number % 100;
    if (number >=11 && number <=19) {
        resultString = [arrayWords objectAtIndex:2];
    }else{
        int i = number % 10;
        switch (i) {
            case 1: resultString = [arrayWords objectAtIndex:0];
                break;
            case 2:
            case 3:
            case 4: resultString = [arrayWords objectAtIndex:1];
                break;
            default:
                resultString = [arrayWords objectAtIndex:2];
                break;
        }
    }
    return resultString;
}

+(NSString*)ending:(NSInteger)index words:(NSArray*)words
{
    
    NSString* testedWord = @"";
    for (int i=1; i<=100; i++) {
        testedWord = [self getWorkByDeclension:i :words];
        if(i==index)
            return testedWord;
    }
    return nil;
    
}

@end
