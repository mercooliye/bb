//
//  RegViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 11.07.18.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "RegViewController.h"
#import <InstagramEngine.h>
#import "ConfirmViewController.h"
#import "Api.h"

@interface RegViewController ()

@end

@implementation RegViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"SFUIText-Regular" size:16]}];
    [self setTitle:NSLocalizedString(@"РЕГИСТРАЦИЯ", @"РЕГИСТРАЦИЯ")];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.center=self.scrollView.center;
    
    self.phoneTextField.maskedTextField.returnKeyType=UIReturnKeyDone;
    self.passTextField.returnKeyType=UIReturnKeyGo;
    self.passTextField.delegate=self;
    [self.phoneTextField setMask:@"+7 (###) ###-##-##"];
    [self.phoneTextField.maskedTextField setBackgroundColor:[UIColor clearColor]];
    [self.phoneTextField.maskedTextField setTextColor:[UIColor whiteColor]];
    [self.phoneTextField showMask];
    
    [self.passTextField setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.view endEditing:YES];
    return NO;
}
- (IBAction)reg:(id)sender {
    
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
    if(_passTextField.text.length==0||
       _passTextField.text.length<6)
    {
        [self openMessage:@"Пароль должен быть не менее 6 символов"];
        return;
    }
    [self startSpin];
    NSMutableDictionary *params=[NSMutableDictionary new];
    [params setObject:_phoneTextField.getRawInputText forKey:@"phone"];
    [params setObject:_passTextField.text forKey:@"password"];
    [self registration:params];
}
- (IBAction)toFB:(id)sender {
    [self authFB];
}

- (IBAction)toVk:(id)sender {
    [self authVK];
}

-(void)authVK
{
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

//метод протокола VKSdkUIDelegate
- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result
{
    if (result.token) {
        // Пользователь успешно авторизован
        [self getVKinfo];
    } else if (result.error) {
        // Пользователь отменил авторизацию или произошла ошибка
    }
}
- (void)vkSdkAuthorizationStateUpdatedWithResult:(VKAuthorizationResult *)result
{
    if (result.token) {
        // Пользователь успешно авторизован
        // [self getVKinfo];
    } else if (result.error) {
        // Пользователь отменил авторизацию или произошла ошибка
    }
}
- (void)vkSdkUserAuthorizationFailed
{
    
}
- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError
{
    VKCaptchaViewController *vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self];
}

-(void)getVKinfo
{
    NSDictionary *params=[[NSDictionary alloc] initWithObjectsAndKeys:[[VKSdk accessToken] userId],VK_API_OWNER_ID,@[@"nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities"],@"fields",nil];
    
    VKRequest * reqUser = [[VKApi users] get:params];
    [reqUser executeWithResultBlock:^(VKResponse *response) {
        NSLog(@"Json result: %@", response.json);
        NSDictionary *result=(NSDictionary*)[response.json objectAtIndex:0];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        
        [params setObject:[NSString stringWithFormat:@"%.0f",[[result objectForKey:@"sex"]floatValue]-1] forKey:@"sex"];
        if([result objectForKey:@"age"])
            [params setObject:[result objectForKey:@"age"] forKey:@"age"];
        if([result objectForKey:@"first_name"])
            [params setObject:[result objectForKey:@"first_name"] forKey:@"name"];
        if([result objectForKey:@"last_name"])
            [params setObject:[result objectForKey:@"last_name"] forKey:@"lastName"];
        if([result objectForKey:@"photo_100"])
            [params setObject:[result objectForKey:@"photo_100"] forKey:@"avatar"];
        if([result objectForKey:@"domain"])
            [params setObject:[NSString stringWithFormat:@"http://vk.com/%@", [result objectForKey:@"domain"] ]forKey:@"site"];
        if([result objectForKey:@"email"])
            [params setObject:[result objectForKey:@"email"] forKey:@"email"];
        if([result objectForKey:@"mobile_phone"])
            [params setObject:[result objectForKey:@"mobile_phone"] forKey:@"phone"];
        
        [params setObject:[result objectForKey:@"id"] forKey:@"uid"];
        
        [self registrationWithSM:params isVK:YES];

        
    } errorBlock:^(NSError * error) {
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        } else {
            NSLog(@"VK error: %@", error);
        }
    }];
}

-(void)authFB
{
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
    [newParams setObject:self.mySwitch.isOn?@"1":@"0" forKey:@"note"];
    
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

-(void)instagramm
{
    InstagramKitLoginScope scope = InstagramKitLoginScopeRelationships | InstagramKitLoginScopeComments | InstagramKitLoginScopeLikes;
    
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURLForScope:scope];
    UIWebView *web=[[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:web];
    web.delegate=self;
    [web loadRequest:[NSURLRequest requestWithURL:authURL]];

}

- (void)keyboardWillShow:(NSNotification *)note
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut ];
    //[self.scrollView setCenter:CGPointMake(self.scrollView.center.x, self.center.y-50)];
    [UIView commitAnimations];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)keyboardDidHide:(NSNotification *)note
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut ];
    [self.scrollView setCenter:self.center];
     [UIView commitAnimations];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

@end
