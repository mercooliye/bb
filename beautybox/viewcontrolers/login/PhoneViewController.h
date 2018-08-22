//
//  PhoneViewController.h
//  beautybox
//
//  Created by Evgeniy Merkulov on 17.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCMaskedTextFieldView.h"

@interface PhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet OCMaskedTextFieldView *phoneTextField;
@property NSString *purePhone;
@end
