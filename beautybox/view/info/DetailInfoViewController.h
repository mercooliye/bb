//
//  DetailInfoViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 06.08.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSString *text;
@end
