//
//  UIImage+Rotate.h
//  brronline
//
//  Created by Evgeniy Merkulov on 29.10.17.
//  Copyright © 2017 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)
+ (UIImage *)image:(UIImage *)imageToRotate RotatedByDegrees:(CGFloat)degrees;
+ (UIImage *) imageWithView:(UIView *)view;

@end
