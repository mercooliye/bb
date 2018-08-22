//
//  Singleton.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton * shared = NULL;



+(Singleton *)shared {
    if (!shared || shared == NULL) {
        shared = [Singleton new];
    }
    return shared;
}

@end
