//
//  UIViewController+Utils.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTMaterialSpinner.h"

@interface UIViewController (Utils)
@property JTMaterialSpinner *spinner;
-(void)startSpin;
-(void)stopSpin;
-(double)width;
-(double)height;
-(void)openMessage:(NSString*)message;

@end
