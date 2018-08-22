//
//  ConfirmViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 14.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "ConfirmViewController.h"
#import "Api.h"
#import "UIViewController+Utils.h"
#import "ForgotViewController.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _codeTextField.keyboardType=UIKeyboardTypeNumberPad;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:16]}];
    if(self.forgot)
        [self setTitle:NSLocalizedString(@"ВОССТАНОВЛЕНИЕ ПАРОЛЯ", @"ВОССТАНОВЛЕНИЕ ПАРОЛЯ")];
    else
        [self setTitle:NSLocalizedString(@"ПОДТВЕРЖДЕНИЕ ТЕЛЕФОНА", @"ПОДТВЕРЖДЕНИЕ ТЕЛЕФОНА")];

    self.code=arc4random_uniform(9000)+1000;
    if(!self.forgot)
        [Api sendSMSWithToken:self.token?:@"" phone:self.phone?:@"" code:[NSString stringWithFormat:@"%d", self.code] block:^(NSObject *result) {
        
    }];
    else
    {
        [Api sendSMSResetWithToken:self.token?:@"" phone:self.phone?:@"" code:[NSString stringWithFormat:@"%d", self.code] block:^(NSObject *result) {
            
        }];
    }
    

    
}
- (IBAction)send:(id)sender {
    
    if([_codeTextField.text isEqualToString:[NSString stringWithFormat:@"%d", self.code]])
    {
        if(!self.forgot)
        {
        [Api confirmSMSWithToken:self.token block:^(NSObject *result) {
            NSDictionary *res=(NSDictionary*)result;
            if([res objectForKey:@"token"])
            {
                
            [[NSUserDefaults standardUserDefaults] setObject:[res objectForKey:@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Main"];
            [self presentViewController:myVC animated:YES completion:nil];
            }
            else
            {
                [self openMessage:NSLocalizedString(@"Ошибка регистрации", @"Ошибка регистрации")];
            }
        }];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            ForgotViewController *myVC = (ForgotViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ForgotViewController"];
            myVC.phone=self.phone;
            myVC.token=self.token;
            
            [self.navigationController pushViewController:myVC animated:YES];
            
         }
    }
    else
    {
        [self openMessage:NSLocalizedString(@"Не верный код", @"Не верный код")];
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
