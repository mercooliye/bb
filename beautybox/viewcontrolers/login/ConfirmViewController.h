//
//  ConfirmViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 14.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property NSInteger code;
@property BOOL forgot;
@property NSString *phone;
@property NSString *token;
@end
