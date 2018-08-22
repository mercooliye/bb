//
//  FstViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface FstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property NSTimer *timer;
@end
