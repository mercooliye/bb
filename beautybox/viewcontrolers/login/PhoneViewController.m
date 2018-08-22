//
//  PhoneViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 17.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "PhoneViewController.h"
#import "ConfirmViewController.h"
#import "UIViewController+Utils.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"ВОССТАНОВЛЕНИЕ ПАРОЛЯ", @"ВОССТАНОВЛЕНИЕ ПАРОЛЯ")];
    self.navigationItem.title = NSLocalizedString(@"ВОССТАНОВЛЕНИЕ ПАРОЛЯ", @"ВОССТАНОВЛЕНИЕ ПАРОЛЯ");

    self.phoneTextField.maskedTextField.returnKeyType=UIReturnKeyDone;

    [self.phoneTextField setMask:@"+7 (###) ###-##-##"];
    [self.phoneTextField.maskedTextField setBackgroundColor:[UIColor clearColor]];
    [self.phoneTextField.maskedTextField setTextColor:[UIColor whiteColor]];
    [self.phoneTextField showMask];
    [self.phoneTextField setRawInput:self.purePhone?:@""];
    
}
- (IBAction)send:(id)sender {
    
    if(self.phoneTextField.getRawInputText.length==10)
    {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    ConfirmViewController *myVC = (ConfirmViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ConfirmViewController"];
    myVC.forgot=YES;
    myVC.phone=self.phoneTextField.getRawInputText;
    [self.navigationController pushViewController:myVC animated:YES];
    self.navigationItem.title = @"";
    }
    else
    {
        [self openMessage:NSLocalizedString(@"Введите номер телефона", @"Введите номер телефона")];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
