//
//  WorkTimeViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 02.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkView.h"

@interface WorkTimeViewController : UIViewController
@property WorkView *workView;
@property NSArray *work;
@property  UIScrollView *scrollView;
@end
