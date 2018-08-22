//
//  RegViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import <VKSdk.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKGraphRequestConnection.h>
#import "OCMaskedTextFieldView.h"
#import "UIViewController+Utils.h"

@interface RegViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passTextField;
 @property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet OCMaskedTextFieldView *phoneTextField;
@property JTMaterialSpinner *spinner;
@property (weak, nonatomic) IBOutlet UIButton *regButton;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;

@property UITableView *tableView;
@property CGPoint center;
@end
