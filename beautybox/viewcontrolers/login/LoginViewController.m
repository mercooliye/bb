//
//  LoginViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 15.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Main.h"
#import "UIViewController+Utils.h"
#import "Api.h"
#import "ConfirmViewController.h"
#import "PhoneViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self setTitle:NSLocalizedString(@"АВТОРИЗАЦИЯ", @"АВТОРИЗАЦИЯ")];
    self.navigationItem.title = NSLocalizedString(@"АВТОРИЗАЦИЯ", @"АВТОРИЗАЦИЯ");
}
- (IBAction)forgot:(id)sender {
    
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
     PhoneViewController *myVC = (PhoneViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PhoneViewController"];
    if(self.phoneTextField.getRawInputText.length==10)
        myVC.purePhone=self.phoneTextField.getRawInputText;
    [self.navigationController pushViewController:myVC animated:YES];
    self.navigationItem.title = @"";
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:16]}];
    
   

    
    self.phoneTextField.maskedTextField.returnKeyType=UIReturnKeyDone;
    self.passTextField.returnKeyType=UIReturnKeyGo;
    self.passTextField.delegate=self;
    [self.phoneTextField setMask:@"+7 (###) ###-##-##"];
    [self.phoneTextField.maskedTextField setBackgroundColor:[UIColor clearColor]];
    [self.phoneTextField.maskedTextField setTextColor:[UIColor whiteColor]];
    [self.phoneTextField showMask];
    [self.passTextField setValue:[UIColor whiteColor]
                      forKeyPath:@"_placeholderLabel.textColor"];
    
    NSMutableDictionary *defaultAttributes = [@{NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:13],
                                                NSForegroundColorAttributeName:[UIColor orange] }mutableCopy];
    
    [self.bottomTextView linkString:@"зарегистрируйтесь."
           defaultAttributes:defaultAttributes
       highlightedAttributes:defaultAttributes
                  tapHandler:^(NSString *linkedString) {
                   
                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                      UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RegViewController"];
                      [self.navigationController pushViewController:myVC animated:YES];
                      self.navigationItem.title = @"";
                      
                  }];
    
    
}
- (IBAction)login:(id)sender {
    
    if(_phoneTextField.getRawInputText.length==0&&
       _passTextField.text.length==0)
    {
        [self openMessage:@"Введите номер телефона и пароль"];
        return;
    }
    if(_phoneTextField.getRawInputText.length==0)
    {
        [self openMessage:@"Введите номер телефона"];
        return;
    }
    
    if(_phoneTextField.getRawInputText.length<10)
    {
        [self openMessage:@"Введите корректный номер телефона"];
        return;
    }
    
    if(_passTextField.text.length==0)
    {
        [self openMessage:@"Введите пароль"];
        return;
    }
    UIButton *btn=(UIButton*)sender;
    btn.hidden=YES;
    
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setObject:self.phoneTextField.getRawInputText forKey:@"phone"];
    [params setObject:self.passTextField.text forKey:@"password"];
    [self startSpin];
    [Api login:params block:^(NSObject *result) {
        [self stopSpin];
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
        else
        {
            NSDictionary* data=[(NSDictionary*)result objectForKey:@"data"] ;
            if([data objectForKey:@"text"])
                [self openMessage:[data objectForKey:@"text"]];
        }

    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toFB:(id)sender {
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    loginManager.loginBehavior = FBSDKLoginBehaviorSystemAccount;
    
    [loginManager logInWithReadPermissions:@[@"public_profile"]
                        fromViewController:self
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       //TODO: process error or result.
                                       [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,last_name,gender,id,link"}]
                                        startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                            if (!error) {
                                                NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
                                                [params setObject:[result objectForKey:@"name"] forKey:@"name"];
                                                if([result objectForKey:@"last_name"])
                                                    [params setObject:[result objectForKey:@"last_name"] forKey:@"lastName"];
                                                if([result objectForKey:@"gender"])
                                                    [params setObject:[result objectForKey:@"gender"] forKey:@"gender"];
                                                if([result objectForKey:@"email"])
                                                    [params setObject:[result objectForKey:@"email"] forKey:@"email"];
                                                if([result objectForKey:@"link"])
                                                    [params setObject:[result objectForKey:@"link"] forKey:@"sm_link"];
                                                
                                                [params setObject:[result objectForKey:@"id"] forKey:@"uid"];
                                                
                                                [self registrationWithSM:params isVK:NO];
                                            }
                                        }];
                                       
                                   }];
    
    
}
- (IBAction)toVK:(id)sender {
    
    NSArray *SCOPE = @[@"friends", @"email",@"offline"];
    [VKSdk initializeWithAppId:@"6633142" ];
    [[VKSdk instance] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        [VKSdk authorize:SCOPE];
        
        if (state == VKAuthorizationAuthorized) {
            // Authorized and ready to go
            
        } else if (error) {
            // Some error happend, but you may try later
            
        }
    }];
    
}


-(void)registrationWithSM:(NSDictionary*)params isVK:(BOOL)isVK
{
    [self startSpin];
    [Api loginWithSMWithVK:isVK userId:[params objectForKey:@"uid"] name:[params objectForKey:@"name"] block:^(NSObject *result) {
        [self stopSpin];
        NSInteger status=[[(NSDictionary*)result objectForKey:@"status"] integerValue];
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
        else
        {
            NSDictionary* data=[(NSDictionary*)result objectForKey:@"data"] ;
            if([data objectForKey:@"text"])
                [self openMessage:[data objectForKey:@"text"]];
            else
            {
                [self openMessage:NSLocalizedString(@"Неизвестная ошибка", @"Неизвестная ошибка")];
            }
        }
        
    }];
    
}

-(void)registration:(NSDictionary*)params
{
    NSMutableDictionary *newParams=[NSMutableDictionary dictionaryWithDictionary:params];

    
    [Api registration:newParams block:^(NSObject *result) {
        [self stopSpin];
        NSDictionary *data=[(NSDictionary*)result objectForKey:@"data"]?:nil;
        if([(NSDictionary*)result objectForKey:@"text"])
        {
            //[self openMessage:[(NSDictionary*)result objectForKey:@"text"]];
        }
        
        if(YES)
        {
            
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            ConfirmViewController *myVC = (ConfirmViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ConfirmViewController"];
            if(data)
            {
                myVC.token=[data objectForKey:@"access_token"];
                myVC.phone=self.phoneTextField.getRawInputText;
            }
            else
            {
                [self openMessage:NSLocalizedString(@"Ошибка регистрации", @"Ошибка регистрации")];
                return ;
            }
            
            [self.navigationController pushViewController:myVC animated:YES];
        }
        
    }];
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
