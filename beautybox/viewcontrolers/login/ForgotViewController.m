//
//  ForgotViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 15.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "ForgotViewController.h"
#import "Api.h"
@interface ForgotViewController ()

@end

@implementation ForgotViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self setTitle:NSLocalizedString(@"ВОССТАНОВЛЕНИЕ ПАРОЛЯ", @"ВОССТАНОВЛЕНИЕ ПАРОЛЯ")];
    self.navigationItem.title = NSLocalizedString(@"ВОССТАНОВЛЕНИЕ ПАРОЛЯ", @"ВОССТАНОВЛЕНИЕ ПАРОЛЯ");
}
- (IBAction)reset:(id)sender
{
    if(_passTextField.text.length!=0&&
       [_passTextField.text isEqualToString:_repeatTextField.text])
    {
    UIButton *btn=(UIButton*)sender;
    btn.hidden=YES;
    
    [self startSpin];
    [Api resetPasswordWithToken:self.token phone:self.phone password:self.passTextField.text block:^(NSObject *result) {
       
        
       
        NSInteger status=[[(NSDictionary*)result objectForKey:@"status"] integerValue];
        [self stopSpin];
        btn.hidden=NO;
        
        if(status==200)
        {
            NSDictionary *data=[(NSDictionary*)result objectForKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userinfo"];
            [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"access_token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Main"];
            [self presentViewController:myVC animated:YES completion:nil];
            
 
        }
    }];
    }
    else
    {
        [self openMessage:NSLocalizedString(@"Пароли не совпадают", @"Пароли не совпадают")];
    }
     
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:16]}];
    
    [self.passTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    [self.repeatTextField setValue:[UIColor whiteColor]
                        forKeyPath:@"_placeholderLabel.textColor"];
    self.passTextField.secureTextEntry=YES;
    self.repeatTextField.secureTextEntry=YES;

    
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
