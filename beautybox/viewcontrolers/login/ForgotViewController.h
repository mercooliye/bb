//
//  ForgotViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 15.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Utils.h"

@interface ForgotViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatTextField;
@property NSString *token;
@property NSString *phone;
@property JTMaterialSpinner *spinner;
@end
