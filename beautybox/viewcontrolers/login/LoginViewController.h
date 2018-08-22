//
//  LoginViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 15.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCMaskedTextFieldView.h"
#import "HBVLinkedTextView.h"
#import "UIViewController+Utils.h"

#import <VKSdk.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKGraphRequestConnection.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet OCMaskedTextFieldView *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet HBVLinkedTextView *bottomTextView;
@property JTMaterialSpinner *spinner;
@end
